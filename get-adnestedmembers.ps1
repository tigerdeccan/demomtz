# Get the group object
$group = Get-MgGroup -Filter "DisplayName eq '$groupName'"

# Get the members of the group
$members += Get-MgGroupMember -GroupId $group.Id

# Get the members of any nested groups
$nestedGroups = Get-MgGroup -All $true | Where-Object {$_.MemberOf -contains $group.Id}
foreach ($nestedGroup in $nestedGroups) {
    $members += Get-MgGroupMember -GroupId $nestedGroup.Id
}

# Output the members
$members
