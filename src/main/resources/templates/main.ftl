<#import './parts/common.ftl' as c>
<@c.page>
    <form method="get" action="/main" class="form-inline mb-2">
        <div class="form-group mr-2">
            <input type="text" name="tag" value="<#if filter??>${filter}</#if>" class="form-control"
                   placeholder="Enter a tag to filter..">
        </div>
        <button type="submit" class="btn btn-primary">Filter</button>
    </form>

    <#include "parts/messageEdit.ftl" />

    <#include "parts/messageList.ftl" />

</@c.page>