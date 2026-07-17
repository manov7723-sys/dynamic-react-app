# cross-region-peer — cross-region VPC peering
# LEFT:  vpc-0458a23d9cb5dfece (us-east-1, 10.0.0.0/16)
# RIGHT: vpc-0710340ffd7174a26 (us-east-2, 172.31.0.0/16)
# Same-account peering. Cross-account is out of scope for this generator.

# Peer_owner_id is the current account (we're same-account). Read it once
# so we don't have to hardcode.
data "aws_caller_identity" "left" {
  provider = aws.left
}

resource "aws_vpc_peering_connection" "this" {
  provider      = aws.left
  vpc_id        = "vpc-0458a23d9cb5dfece"
  peer_vpc_id   = "vpc-0710340ffd7174a26"
  peer_region   = "us-east-2"
  peer_owner_id = data.aws_caller_identity.left.account_id

  # Cross-region peering CANNOT auto-accept in one call — the requester
  # creates the request; the accepter (below) accepts it in the peer region.
  auto_accept = false

  tags = merge({
    "ManagedBy" = "DeepAgent"
    "Peering" = "cross-region-peer"
    "Environment" = "dev"
    "CreatedBy" = "deepagent-vpc-peering-ui"
  }, { Name = "cross-region-peer", Side = "requester" })
}

resource "aws_vpc_peering_connection_accepter" "this" {
  provider                  = aws.right
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id
  auto_accept               = true

  tags = merge({
    "ManagedBy" = "DeepAgent"
    "Peering" = "cross-region-peer"
    "Environment" = "dev"
    "CreatedBy" = "deepagent-vpc-peering-ui"
  }, { Name = "cross-region-peer", Side = "accepter" })
}

# ── Route wiring — every route table in each VPC gets a route to the peer's CIDR ──
# for_each reads the data source at plan time; the VPCs must already exist.

data "aws_route_tables" "left" {
  provider = aws.left
  vpc_id   = "vpc-0458a23d9cb5dfece"
}

data "aws_route_tables" "right" {
  provider = aws.right
  vpc_id   = "vpc-0710340ffd7174a26"
}

resource "aws_route" "left_to_right" {
  provider                  = aws.left
  for_each                  = toset(data.aws_route_tables.left.ids)
  route_table_id            = each.value
  destination_cidr_block    = "172.31.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id

  # Route must exist AFTER the accepter has accepted, or AWS returns "invalid
  # peering connection state" mid-apply.
  depends_on = [aws_vpc_peering_connection_accepter.this]
}

resource "aws_route" "right_to_left" {
  provider                  = aws.right
  for_each                  = toset(data.aws_route_tables.right.ids)
  route_table_id            = each.value
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.this.id

  depends_on = [aws_vpc_peering_connection_accepter.this]
}
