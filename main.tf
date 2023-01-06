module "wh_setup" {
  source = "github.com/jasongholt/sfguide-terraform-sample/modules"
  admin_role_id = "SYSADMIN"
  user_role_id = "SECURITYADMIN"
  db_name = "TF_DEMO_DB"
  wh_name = "TF_DEMO_WH"
  wh_size = "large"
  svc_role_name = "TF_DEMO_SVC_ROLE"
  schema_name = "TF_DEMO_SCHEMA"
  user_id = "tf_demo_user"
}