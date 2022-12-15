variable "aws_access_key" {}
variable "aws_secret_key" {}


variable "rds_username" {
  description = "db username"
  default     = "admin"
}
variable "rds_password" {
  description = "db password"
  default     = "admin123"
}
variable "rds_final_snapshot_identifier" {
  description = "db final snapshot identifier"
  default     = "worker-final"
}