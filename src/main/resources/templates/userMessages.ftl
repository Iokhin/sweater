<#import './parts/common.ftl' as c>
<@c.page>
    <div class="container mb-4">
        <h4 class="mb-3">${user.username}'s messages</h4>
        <div class="row">
            <div class="col">
                <div class="card">
                    <div class="card-body">
                        <div class="card-title">Followers</div>
                        <h3 class="card-text">
                            <a href="/user/followers/${user.id}">${followersCount}</a>
                        </h3>
                    </div>
                </div>
            </div>
            <div class="col">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Subscriptions</h5>
                        <h3 class="card-text">
                            <a href="/user/subscriptions/${user.id}">${subscriptionsCount}</a>
                        </h3>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <#if messageSuccess??>
        <div class="alert alert-success" role="alert">
            ${messageSuccess}
        </div>
    </#if>
    <#if messageError??>
        <div class="alert alert-danger" role="alert">
            ${messageError}
        </div>
    </#if>
    <#if isCurrentUser>
        <#include "parts/messageEdit.ftl" />
    </#if>

    <#include "parts/messageList.ftl" />

</@c.page>