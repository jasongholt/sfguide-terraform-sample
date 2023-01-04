provider "snowflake" {
  role = var.admin_role_id
}

resource "snowflake_database" "db" {
  name = var.db_name
}
resource "snowflake_warehouse" "warehouse" {
  name           = var.wh_name
  warehouse_size = var.wh_size
  auto_suspend   = 60
}
provider "snowflake" {
  alias = "security_admin"
  role  = var.user_role_id
}

resource "snowflake_role" "role" {
  provider = snowflake.security_admin
  name     = var.svc_role_name
}

resource "snowflake_database_grant" "grant" {
  provider          = snowflake.security_admin
  database_name     = snowflake_database.db.name
  privilege         = var.db_grant_priv
  roles             = [snowflake_role.role.name]
  with_grant_option = false
}

resource "snowflake_schema" "schema" {
  database   = snowflake_database.db.name
  name       = var.schema_name
  is_managed = false
}

resource "snowflake_schema_grant" "grant" {
  provider          = snowflake.security_admin
  database_name     = snowflake_database.db.name
  schema_name       = snowflake_schema.schema.name
  privilege         = var.schema_grant_priv
  roles             = [snowflake_role.role.name]
  with_grant_option = false
}

resource "snowflake_warehouse_grant" "grant" {
  provider          = snowflake.security_admin
  warehouse_name    = snowflake_warehouse.warehouse.name
  privilege         = var.wh_grant_priv
  roles             = [snowflake_role.role.name]
  with_grant_option = false
}

resource "tls_private_key" "svc_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "snowflake_user" "user" {
  provider          = snowflake.security_admin
  name              = var.user_id
  default_warehouse = snowflake_warehouse.warehouse.name
  default_role      = snowflake_role.role.name
  default_namespace = "${snowflake_database.db.name}.${snowflake_schema.schema.name}"
  rsa_public_key    = substr(tls_private_key.svc_key.public_key_pem, 27, 398)
}

resource "snowflake_role_grants" "grants" {
  provider  = snowflake.security_admin
  role_name = snowflake_role.role.name
  users     = [snowflake_user.user.name]
}

