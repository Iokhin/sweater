<#import './parts/common.ftl' as c>
<@c.page>
    <form method="get" action="/main" class="form-inline mb-2">
        <div class="form-group mr-2">
            <input type="text" name="tag" value="${filter}" class="form-control" placeholder="Enter a tag to filter..">
        </div>
        <button type="submit" class="btn btn-primary">Filter</button>
    </form>
    <a class="btn btn-primary" data-toggle="collapse" href="#collapseArea" role="button" aria-expanded="false" aria-controls="collapseArea">
        Add message
    </a>
    <div class="collapse my-2" id="collapseArea">
        <form action="/message-add" id="message-add-form" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <input class="form-control" type="text" name="text" placeholder="Message text...">
            </div>
            <div class="form-group">
                <input class="form-control" type="text" name="tag" placeholder="Message tag..">
            </div>
            <div class="custom-file">
                <input type="file" class="custom-file-input" id="customFile" name="file">
                <label class="custom-file-label" for="customFile">Choose file</label>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <div class="form-group">
                <button class="btn btn-primary mt-2" type="submit">Add</button>
            </div>
        </form>
    </div>
    <div class="card-columns my-3">
    <#list messages as message>
        <div class="card">
            <#if message.filename??>
                <img class="card-img-top p-1" src="/img/${message.filename}" alt="Card image cap">
            </#if>
            <div class="card-body">
                <i>${message.tag}</i>
                <p class="card-text">${message.text}</p>
            </div>
            <div class="card-footer">
                <p>${message.authorName}</p>
            </div>
        </div>
    <#else>
        <div><code>NO MESSAGES</code></div>
    </#list>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bs-custom-file-input/dist/bs-custom-file-input.min.js"></script>
    <script>
        bsCustomFileInput.init();
    </script>
</@c.page>