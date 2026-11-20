# In 365 Admin, Settings > Org settings > Self-service trials and purchases.
# This sets all self-service options to Do not allow.
# Copilot created this. I verified that it works correctly.

# Install once if needed
Install-Module MSCommerce -Scope CurrentUser

Import-Module MSCommerce

# Interactive sign-in to the tenant
Connect-MSCommerce

# Get every product that supports self-service purchase/trial
$Products = Get-MSCommerceProductPolicies `
    -PolicyId AllowSelfServicePurchase

# Disable anything that isn't already disabled
foreach ($Product in $Products) {

    if ($Product.PolicyValue -ne "Disabled") {

        Write-Host "Disabling: $($Product.ProductName)" -ForegroundColor Yellow

        Update-MSCommerceProductPolicy `
            -PolicyId AllowSelfServicePurchase `
            -ProductId $Product.ProductId `
            -Value "Disabled"
    }
    else {
        Write-Host "Already disabled: $($Product.ProductName)" -ForegroundColor Green
    }
}

# Verify final configuration
Get-MSCommerceProductPolicies `
    -PolicyId AllowSelfServicePurchase |
    Format-Table ProductName, ProductId, PolicyValue -AutoSize
