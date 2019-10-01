<#macro login path isRegisterForm>
    <#if message??>
        <div>${message}</div>
    </#if>
    <form action="/${path}" method="post">
        <div class="form-group row">
            <label for="username" class="col-sm-2 col-form-label">Username</label>
            <div class="col-sm-6">
                <input class="form-control <#if usernameError??>is-invalid</#if>" type="text" id="username"
                       name="username" placeholder="Username" value="<#if user??>${user.username}</#if>"/>
                <#if usernameError??>
                    <div class="invalid-feedback">
                        ${usernameError}
                    </div>
                </#if>
            </div>
        </div>
        <div class="form-group row">
            <label for="password" class="col-sm-2 col-form-label">Password</label>
            <div class="col-sm-6">
                <input class="form-control <#if passwordError??>is-invalid</#if>" type="password" id="password"
                       name="password" placeholder="Password"/>
                <#if passwordError??>
                    <div class="invalid-feedback">
                        ${passwordError}
                    </div>
                </#if>
            </div>
        </div>
        <#if isRegisterForm>
            <div class="form-group row">
                <label for="password2" class="col-sm-2 col-form-label">Password confirmation</label>
                <div class="col-sm-6">
                    <input class="form-control <#if password2Error??>is-invalid</#if>" type="password" id="password2"
                           name="password2" placeholder="Retype password.."/>
                    <#if password2Error??>
                        <div class="invalid-feedback">
                            ${password2Error}
                        </div>
                    </#if>
                </div>
            </div>
            <div class="form-group row">
                <label for="email" class="col-sm-2 col-form-label">Email</label>
                <div class="col-sm-6">
                    <input class="form-control <#if emailError??>is-invalid</#if>" type="email" id="email" name="email"
                           placeholder="some@some.com" value="<#if user??>${user.email}</#if>"/>
                    <#if emailError??>
                        <div class="invalid-feedback">
                            ${emailError}
                        </div>
                    </#if>
                </div>
            </div>
        </#if>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <div class="form-group row">
            <div class="col-sm-10">
                <button type="submit" class="btn btn-primary"><#if isRegisterForm>Register<#else>Sign In</#if></button>
            </div>
        </div>
    </form>
</#macro>