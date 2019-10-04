<a class="btn btn-primary" data-toggle="collapse" href="#collapseArea" role="button" aria-expanded="false" aria-controls="collapseArea">
    Message editor
</a>
<div class="collapse <#if message?? || showEditor??>show</#if> my-2" id="collapseArea">
    <form id="message-add-form" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <input class="form-control ${(textError??)?string('is-invalid', '')}"
                   value="<#if message??>${message.text}</#if>"
                   type="text" name="text" placeholder="Message text...">
            <#if textError??>
                <div class="invalid-feedback">
                    ${textError}
                </div>
            </#if>
        </div>
        <div class="form-group">
            <input class="form-control ${(tagError??)?string('is-invalid', '')}" type="text" name="tag"
                   placeholder="Message tag.." value="<#if message??>${message.tag}</#if>">
            <#if tagError??>
                <div class="invalid-feedback">
                    ${tagError}
                </div>
            </#if>
        </div>
        <div class="custom-file">
            <input type="file" class="custom-file-input" id="customFile" name="file">
            <label class="custom-file-label" for="customFile">Choose file</label>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <input type="hidden" name="id" value="<#if message??>${message.id}</#if>">
        <div class="form-group">
            <button class="btn btn-primary mt-2" type="submit">Save</button>
        </div>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bs-custom-file-input/dist/bs-custom-file-input.min.js"></script>
<script>
    bsCustomFileInput.init();
</script>
