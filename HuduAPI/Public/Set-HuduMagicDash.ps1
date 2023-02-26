function Set-HuduMagicDash {
    <#
    .SYNOPSIS
    Create or Update a Magic Dash Item

    .DESCRIPTION
    Magic Dash takes just simple key-pairs. Whether you want to add a new Magic Dash Item, or update one, you can use the same endpoint, so it is really easy! It uses the title, and company_name to match.

    .PARAMETER Title
    This is the title. If there is an existing Magic Dash Item with matching title and company_name, then it will match into that item.

    .PARAMETER CompanyName
    This is the attribute we use to match to an existing company. If there is an existing Magic Dash Item with matching title and company_name, then it will match into that item.

    .PARAMETER Message
    This will be the first content that will be displayed on the Magic Dash Item.

    .PARAMETER Icon
    Either fill this in, or image_url. Use a (FontAwesome icon for the header of a Magic Dash Item. Must be in the format of fas fa-circle

    .PARAMETER ImageURL
    Either fill this in, or icon. Used in the header of a Magic Dash Item.

    .PARAMETER ContentLink
    Either fill this in, or content, or leave both blank. Used to have a link to an external website.

    .PARAMETER Content
    Either fill this in, or content_link, or leave both blank. Fill in with HTML (tables, images, videos, etc.) to display more content in your Magic Dash Item.

    .PARAMETER Shade
    Use a different color for your Magic Dash Item for different contextual states. Options are to leave it blank, success, or danger

    .EXAMPLE
    Set-HuduMagicDash -Title 'Test Dash' -CompanyName 'Test Company' -Message 'This will be displayed first'

    #>
    [CmdletBinding(SupportsShouldProcess)]
    Param (
        [Parameter(Mandatory = $true)]
        [String]$Title,

        [Alias('company_name')]
        [Parameter(Mandatory = $true)]
        [String]$CompanyName,

        [Parameter(Mandatory = $true)]
        [String]$Message,

        [String]$Icon = '',

        [Alias('image_url')]
        [String]$ImageURL = '',

        [Alias('content_link')]
        [String]$ContentLink = '',

        [String]$Content = '',

        [String]$Shade = ''
    )

    if ($Icon -and $ImageURL) {
        Write-Error ('You can only use one of icon or image URL')
        exit 1
    }

    if ($content_link -and $content) {
        Write-Error ('You can only use one of content or content_link')
        exit 1
    }

    $MagicDash = [ordered]@{}

    if ($Title) {
        $MagicDash.add('title', $Title)
    }

    if ($CompanyName) {
        $MagicDash.add('company_name', $CompanyName)
    }

    if ($Message) {
        $MagicDash.add('message', $Message)
    }

    if ($Icon) {
        $MagicDash.add('icon', $Icon)
    }

    if ($ImageURL) {
        $MagicDash.add('image_url', $ImageURL)
    }

    if ($ContentLink) {
        $MagicDash.add('content_link', $ContentLink)
    }

    if ($Content) {
        $MagicDash.add('content', $Content)
    }

    if ($Shade) {
        $MagicDash.add('shade', $Shade)
    }

    $JSON = $MagicDash | ConvertTo-Json

    if ($PSCmdlet.ShouldProcess("$Companyname - $Title")) {
        Invoke-HuduRequest -Method post -Resource '/api/v1/magic_dash' -Body $JSON
    }
}
