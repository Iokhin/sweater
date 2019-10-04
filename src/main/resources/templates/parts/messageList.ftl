<#include "security.ftl" />

<div class="card-columns my-3">
    <#list messages as message>
        <div class="card">
            <#if message.filename??>
                <img class="card-img-top p-1" src="/img/${message.filename}" alt="Card image cap">
            </#if>
            <div class="card-body">
                <i>#${message.tag}</i>
                <p class="card-text mt-2">${message.text}</p>
            </div>
            <div class="card-footer">
                <a href="/user-messages/${message.user.id}">${message.authorName}</a>
                <#if message.user.id == currentUserId>
                    <a class="ml-3 btn-sm btn-primary"
                       href="/user-messages/${message.user.id}?message=${message.id}">Edit</a>
                </#if>
            </div>
        </div>
    <#else>
        <div><code>NO MESSAGES</code></div>
    </#list>
</div>
