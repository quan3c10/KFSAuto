txtUsername=    'id:userid'
txtPassword=    'id:password'
btnLogin=    'id:submitspan'

#Tab buttons
btnDevices=    'id:devices'
btnDestinations=    'id:destinations'
btnShortcuts=    'id:shortcuts'
btnProfiles=    'id:profiles'
btnPermissions=    'id:security-roles'
btnUsers=    'id:security-users'
btnGroups=    'id:security-groups'
btnSettings=    'id:settings'

#Tabs
tbGeneral=    "//a[text()='General']"
tbDevices=    "//a[contains(text(),'Device')]"
tbGroups=    "//a[contains(text(),'Groups')]"
tbScanSettings=    "//a[contains(text(),'Scan')]"
tbShortcuts=    "//a[contains(text(),'Shortcut')]"
tbDestinations=    "//a[contains(text(),'Destination')]"
tbUsers=    "//a[contains(text(),'Users')]"
tbActivities=    "//a[contains(text(),'Activities')]"
tbMember=    "//a[contains(text(),'Member')]"
tbPermissions=    "//a[contains(text(),'Permissions')]"
tbAdvanced=    "//a[contains(text(),'Advanced')]"

#Toolbar buttons
btnDelete=    "css:#totalagility-toolbar a:nth-of-type(6)"
btnCreate=    "css:#totalagility-toolbar a:nth-of-type(2)"
btnEdit=    "css:#totalagility-toolbar a:nth-of-type(4)"
btnCancel=    "css:#totalagility-toolbar a:nth-of-type(11)"
btnSave=    "css:#totalagility-toolbar a:nth-of-type(7)"

#Table objects
cbSelectAll=    "//span[@class='slick-column-name']//descendant::input"
txtsearch1=    "//div[@id='myGrid']/div[2]/descendant::input[1]"
txtsearch2=    "//div[@id='myGrid']/div[2]/descendant::input[2]"

#Associate button
btnAssociate=    "css:div[id*='tabs-']:not([style*='none']) button[class='addAvailableButton']"
btnUnassociate=    "css:div[id*='tabs-']:not([style*='none']) button[class='removeAssociatedButton']"

#Select box
bxAssociate=    "css:div[id*='tabs-']:not([style*='none']) div:not([class]) select"
bxAvailable=    "css:div[id*='tabs-']:not([style*='none']) div[class$='list'] select"