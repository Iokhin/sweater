<#import "./parts/common.ftl" as c>
<#import "./parts/login.ftl" as l>
<@c.page>
    <@l.login "login"/>
    <div><a href="/registration"><code>REGISTRATION</code></a></div>
</@c.page>