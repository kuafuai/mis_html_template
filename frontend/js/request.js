function i09rFHchange_Request(data){
    return service({
        method: 'put',
        url: 'http://localhost:8080/system/dict/type',
        data: data
    })
}

function iUOKcustatusGetListRequest(){
    return service({
        method: 'get',
        url: 'http://localhost:8080/system/dict/data/type/sys_normal_disable',
        
    })
}
function iUOKculistRequest(data){
    return service({
        method: 'get',
        url: 'http://localhost:8080/system/dict/type/list',
        params: data
    })
}
function iUOKcueditRequest(data){
    return service({
        method: 'put',
        url: 'http://localhost:8080/system/dict/type',
        data: data
    })
}
function iUOKcuaddRequest(data){
    return service({
        method: 'post',
        url: 'http://localhost:8080/system/dict/type',
        data: data
    })
}
function iUOKcudelRequest(data){
    return service({
        method: 'delete',
        url: 'http://localhost:8080/system/dict/type/'+data,
    })
}

