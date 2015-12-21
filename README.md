# WindowsServerTestLabARMTemplate


<a href="https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Feldanielo%2FWindowsServerTestLabARMTemplate%2Fmaster%2FWindowsServerTestLab%2FTemplates%2FWindowsServerTestLabMultiple.json" target="_blank">
    <img src="http://azuredeploy.net/deploybutton.png"/>
</a>

<a href="https://raw.githubusercontent.com/eldanielo/WindowsServerTestLabARMTemplate/master/azuredeploy.josn" target="_blank">
  <img src="http://armviz.io/visualizebutton.png"/>
</a>
<p>
This Template creates the basic components for the <a href="http://social.technet.microsoft.com/wiki/contents/articles/7807.windows-server-2012-test-lab-guides.aspx">Windows Server Test Lab Guides</a>
</p>

The parameter "labCount" indicates how often the template should be deployed, making it easy to deploy it for multiple lab users. All resources will be deployed in the same Resource Group and will be tagged by a tailing index starting at 0, indicating its iteration.
e.g 
VirtualNetwork_0 </br>
edge-pip_0 </br>
edgeNicOne_0 </br>
edge-0 </br>
represents a single deployment and belong to one user. 
It is recommended not to use any digits for the parameters during deployment as filtering resources by number/user won't be possible. 
</br>
</br>
Default VM Sizes represent the minimum configuration for each VM due to <a href="https://azure.microsoft.com/en-us/documentation/articles/virtual-machines-size-specs/">NIC restrictions. </a>
