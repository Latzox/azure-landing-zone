# Example .ps-rule/GitHub.Community.Rule.ps1

# Synopsis: Check for recommended community files
Rule 'GitHub.Community' -Type 'PSRule.Data.RepositoryInfo' {
    $Assert.FilePath($TargetObject, 'FullName', @('LICENSE'));
    $Assert.FilePath($TargetObject, 'FullName', @('README.md'));
    $Assert.FilePath($TargetObject, 'FullName', @('CODEOWNERS'));
}