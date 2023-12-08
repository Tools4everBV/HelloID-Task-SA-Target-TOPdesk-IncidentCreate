# HelloID-Task-SA-Target-TOPdesk-IncidentCreate

## Prerequisites

- [ ] TOPdesk API Username and Key
- [ ] User-defined variables: `topdeskBaseUrl`, `topdeskApiUsername` and `topdeskApiSecret` created in your HelloID portal.

## Description

This code snippet will create an incident within TOPdesk and executes the following tasks:

1. Define a hash table `$formObject`. The keys of the hash table represent the properties necessary to create an incident within `TOPdesk`, while the values represent the values entered in the form.

> To view an example of the form output, please refer to the JSON code pasted below.

```json
{
  "callerLookup": {
      "id": "40dd8b13-c8d2-4376-b21e-38ba6439ca38"
  },
  "briefDescription": "Incident example",
  "request": "This an example of an incident",
  "action": "Please act on this incident example accordingly",
  "operator": {
      "id": "edaba930-6315-4b5b-b98c-c50bff863cc8"
  },
  "operatorGroup": {
      "id": "2212b3e5-d6dd-4618-a51f-4c4536d235d8"
  },
  "category": {
      "id": "05d3c08e-436c-468a-9fe6-5b3a4ddb156c"
  },
  "subcategory": {
      "id": "17b16491-2c1d-419a-ac6e-a43e73f9cd75"
  },
  "callType": {
      "id": "04b678a6-791e-4662-9bc8-97573555f15e"
  },
  "impact": {
      "id": "047e6eaf-3ef3-5b0f-9e71-0463a0a96d92"
  },
  "urgency": {
      "id": "163e40c1-1907-5766-b35b-31fef04f0910"
  },
  "priority": {
      "id": "f0a5d7d2-d5b0-54fc-a8fe-9e6e1ac09715"
  },
  "duration": {
    "id": "b0abc434-ebe0-58c4-851d-a7bec0fbbb7a"
  },
  "entryType": {
      "id": "32d349bb-c1f5-416a-8314-0c24d328b325"
  },
  "processingStatus": {
      "id": "70b2967d-e248-4ff9-a632-ec044410d5a6"
  },
  "branch": {
      "id": "1fe19024-d652-46ec-b080-eec3737a3d7a"
  }
}
```

> :exclamation: It is important to note that the names of your form fields might differ. Ensure that the `$formObject` hash table is appropriately adjusted to match your form fields.
> [See the TOPdesk API Docs page](https://developers.topdesk.com/explorer/?page=incident#/incident/post_incidents)

2. Creates authorization headers using the provided API key and secret.

3. Create an incident using the: `Invoke-RestMethod` cmdlet. The hash table called: `$formObject` is passed to the body of the: `Invoke-RestMethod` cmdlet as a JSON object.