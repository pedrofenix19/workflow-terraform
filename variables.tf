variable "environment" {
  type = string
}

variable "archivos" {
  type    = map(string)
  default = {
    "archivo1.txt" = "Contenido del archivo 1"
    "archivo1.txt" = "Contenido del archivo 2"
  }
}