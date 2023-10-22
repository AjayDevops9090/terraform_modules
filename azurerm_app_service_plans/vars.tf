variable "asps" {
  type = map(object({
    name                         = string
    resource_group_name          = string
    location                     = string
    os_type                      = string
    sku_name                     = string
    worker_count                 = optional(number)
    maximum_elastic_worker_count = optional(number)
    per_site_scaling_enabled     = optional(bool)
    zone_balancing_enabled       = optional(bool)
  }))
}   