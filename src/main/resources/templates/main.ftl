<#import './parts/common.ftl' as c>
<@c.page>
    <form action="/logout" method="post">
        <input type="submit" value="Sign Out"/>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
    </form>
    <a href="/user"><code>USER LIST</code></a>
    <div>
        <label for="message-add-form">Add new message</label>
        <form action="/message-add" id="message-add-form" method="post" enctype="multipart/form-data">
            <input type="text" name="text">
            <input type="text" name="tag">
            <input type="file" name="file">
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <button type="submit">Add</button>
        </form>
    </div>
    <br>
    <div>
        <label>
            Message filter
            <form method="get" action="/main">
                <input type="text" name="tag" value="${filter}">
                <button type="submit">Filter</button>
            </form>
        </label>
    </div>
    <br>
    <h4>Message list:</h4>
    <#list messages as message>
        <div>
            <strike>${message.id}</strike>
            <code>${message.text}</code>
            <code>${message.tag}</code>
            <strong>${message.authorName}</strong>
            <#if message.filename??>
                <div>
                    <img src="/img/${message.filename}">
                </div>
            </#if>
        </div>
    <#else>
        <div><code>NO MESSAGES</code></div>
    </#list>
</@c.page>