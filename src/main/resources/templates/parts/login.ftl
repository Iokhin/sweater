<#macro login path isRegisterForm>
    <form action="/${path}" method="post">
        <div class="form-group row">
            <label for="username" class="col-sm-2 col-form-label">Username</label>
            <div class="col-sm-6">
                <input class="form-control" type="text" id="username" name="username" placeholder="Username"/>
            </div>
        </div>
        <div class="form-group row">
            <label for="password" class="col-sm-2 col-form-label">Password</label>
            <div class="col-sm-6">
                <input class="form-control" type="password" id="password" name="password" placeholder="Password"/>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <div class="form-group row">
            <div class="col-sm-10">
                <button type="submit" class="btn btn-primary"><#if isRegisterForm>Register<#else>Sign In</#if></button>
            </div>
        </div>
    </form>
</#macro>