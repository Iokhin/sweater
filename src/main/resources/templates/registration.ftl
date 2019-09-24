<#import "./parts/common.ftl" as c>
<#import "./parts/login.ftl" as l>
<@c.page>
    <h3>${message?if_exists}</h3>
        <div class="mb-1"><code>REGISTRATION</code></div>
        <@l.login "registration" true/>
</@c.page>
