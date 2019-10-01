<#import "./parts/common.ftl" as c>
<#import "./parts/login.ftl" as l>
<@c.page>
    <#if usernameError2??>
        <div class="alert alert-danger" role="alert">
            ${usernameError2}
        </div>
    </#if>
    <div class="mb-1"><code>REGISTRATION</code></div>
    <@l.login "registration" true/>
</@c.page>
