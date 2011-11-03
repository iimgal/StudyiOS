<span class="brown">#import</span> <span class="red">"AddressBook/AddressBook.h"</span>
<span class="brown">#import</span> <span class="red">"AddressBookUI/AddressBookUI.h"</span>
<span class="green">// 实现以下委托</span>
<span class="purple">ABPeoplePickerNavigationControllerDelegate, ABNewPersonViewControllerDelegate,ABPersonViewControllerDelegate,ABUnknownPersonViewControllerDelegate</span>
<span class="green">// 查看联系人</span>
<span class="purple">ABPeoplePickerNavigationController</span>*picker = [[<span class="purple">ABPeoplePickerNavigationController alloc] init</span>];
<span class="green">// 得到地址薄</span>
<span class="purple">ABAddressBookRef</span>addressBook = <span class="purple">ABAddressBookCreate</span>();
<span class="green">// 寻找名为“CC”的联系人</span>
<span class="purple">NSArray</span>*people = (<span class="purple">NSArray</span>*)<span class="purple">ABAddressBookCopyPeopleWithName</span>(addressBook, <span class="brown">CFSTR</span>("<span class="red">CC"</span>));
<span class="green">// 新增联系人</span>
<span class="purple">ABNewPersonViewController</span>*picker = [[<span class="purple">ABNewPersonViewController alloc] init</span>];