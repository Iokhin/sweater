<#import "./parts/common.ftl" as c>

<@c.page>
    <code>USER EDITOR</code>
    <form action="/user" method="post">
        <input type="hidden" name="userId" value="${user.id}">
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <label>
            Username:
            <input type="text" name="username" value="${user.username}">
        </label>
        <br>
        <label>
            Roles:
            <br>
            <#list roles as role>
                <div>
                    <label>
                        ${role}
                        <input type="checkbox" name="${role}" ${user.roles?seq_contains(role)?string("checked", "")}>
                    </label>
                </div>
            </#list>
        </label>
        <br>
        <button type="submit"><code>SAVE</code></button>
    </form>
</@c.page>