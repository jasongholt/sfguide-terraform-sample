variable "admin_role_id" {
    type = string
    default = "SYSADMIN"
    }
variable "db_name" {
    type = string
    default = ""
    }

variable "wh_name" {
    type = string
    default = ""
    }

variable "wh_size" {
    type = string
    default = "xsmall"
    }

variable "user_role_id" {
    type = string
    default = "SECURITYADMIN"
    }

variable "user_role_alias" {
    type = string
    default = "security_admin"
    }

variable "svc_role_name" {
    type = string
    default = ""
    }

variable "schema_name" {
    type = string
    default = ""
    }

variable "db_grant_priv" {
    type = string
    default = "USAGE"
    }

variable "schema_grant_priv" {
    type = string
    default = "USAGE"
    }

variable "wh_grant_priv" {
    type = string
    default = "USAGE"
    }

variable "user_id" {
    type = string
    default = ""
    }