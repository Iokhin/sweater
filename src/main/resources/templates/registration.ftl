<#import "./parts/common.ftl" as c>
<#import "./parts/login.ftl" as l>
<@c.page>
    <h3>${message?if_exists}</h3>
    <lable>
        REGISTRATION
        <@l.login "registration"/>
    </lable>
</@c.page>
