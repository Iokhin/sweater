<#import "./parts/common.ftl" as c>
<@c.page>
    <h5>${username}</h5>
    <form method="post">
        <div class="form-group row">
            <label for="password" class="col-sm-2 col-form-label">Password</label>
            <div class="col-sm-6">
                <input class="form-control" type="password" id="password" name="password" placeholder="Password"/>
            </div>
        </div>
        <div class="form-group row">
            <label for="email" class="col-sm-2 col-form-label">Email</label>
            <div class="col-sm-6">
                <input class="form-control" type="email" id="email" name="email" placeholder="some@some.com"
                value="${email!''}"/>
            </div>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <div class="form-group row">
            <div class="col-sm-10">
                <button type="submit" class="btn btn-primary">Save</button>
            </div>
        </div>
    </form>
</@c.page>