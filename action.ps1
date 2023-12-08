# TOPdesk-Task-SA-Target-TOPdesk-IncidentCreate
###########################################################
# Form mapping
$formObject = @{
    callerLookup     = $form.callerLookup
    briefDescription = $form.briefDescription
    request          = $form.request
    action           = $form.action
    operator         = $form.operator
    operatorGroup    = $form.operatorGroup
    category         = $form.category
    subcategory      = $form.subcategory
    callType         = $form.callType
    impact           = $form.impact
    urgency          = $form.urgency
    priority         = $form.priority
    duration         = $form.duration
    entryType        = $form.entryType
    processingStatus = $form.processingStatus
    branch           = $form.branch
}

try {
    Write-Information "Executing TOPdesk action: [CreateIncident] for: [$($formObject.briefDescription)]"
    Write-Verbose "Creating authorization headers"
    # Create authorization headers with TOPdesk API key
    $pair = "${topdeskApiUsername}:${topdeskApiSecret}"
    $bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
    $base64 = [System.Convert]::ToBase64String($bytes)
    $key = "Basic $base64"
    $headers = @{
        "authorization" = $Key
        "Accept"        = "application/json"
    }

    Write-Verbose "Creating TOPdesk Incident: [$($formObject.briefDescription)]"
    $splatCreateIncidentParams = @{
        Uri         = "$($topdeskBaseUrl)/tas/api/incidents"
        Method      = "POST"
        Body        = ([System.Text.Encoding]::UTF8.GetBytes(($formObject | ConvertTo-Json -Depth 10)))
        Verbose     = $false
        Headers     = $headers
        ContentType = "application/json; charset=utf-8"
    }
    $response = Invoke-RestMethod @splatCreateIncidentParams

    $auditLog = @{
        Action            = "CreateResource"
        System            = "TOPdesk"
        TargetIdentifier  = [String]$response.id
        TargetDisplayName = [String]$response.number
        Message           = "TOPdesk action: [CreateIncident] for: [$($formObject.briefDescription)] executed successfully"
        IsError           = $false
    }
    Write-Information -Tags "Audit" -MessageData $auditLog

    Write-Information "TOPdesk action: [CreateIncident] for: [$($formObject.briefDescription)] executed successfully"
}
catch {
    $ex = $_
    $auditLog = @{
        Action            = "CreateResource"
        System            = "TOPdesk"
        TargetIdentifier  = ""
        TargetDisplayName = [String]$formObject.briefDescription
        Message           = "Could not execute TOPdesk action: [CreateIncident] for: [$($formObject.briefDescription)], error: $($ex.Exception.Message)"
        IsError           = $true
    }
    if ($($ex.Exception.GetType().FullName -eq "Microsoft.PowerShell.Commands.HttpResponseException")) {
        $auditLog.Message = "Could not execute TOPdesk action: [CreateIncident] for: [$($formObject.briefDescription)]"
        Write-Error "Could not execute TOPdesk action: [CreateIncident] for: [$($formObject.briefDescription)], error: $($ex.ErrorDetails)"
    }
    Write-Information -Tags "Audit" -MessageData $auditLog
    Write-Error "Could not execute TOPdesk action: [CreateIncident] for: [$($formObject.briefDescription)], error: $($ex.Exception.Message)"
}
###########################################################