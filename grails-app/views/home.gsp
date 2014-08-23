<g:include view="includes/header.gsp"></g:include>
<h1 style="margin-left: 10px;">My Grocery Lists</h1>
<div id="allLists" class="panelContainer">

</div>
</div>
<script>

    var mainData;

    $(function(){

        getAllLists();
        $(document).on('click','.runList input[type=checkbox]',function(e){
            var listItemObject = getListItemObject($(e.target).parent()[0].id.split('_')[1]);
            if(e.target.checked){
                $(e.target).parent().addClass('listItemChecked');
                listItemObject.checked = true;
            }else{
                $(e.target).parent().removeClass('listItemChecked');
                listItemObject.checked = false;
            }

            saveListItem(listItemObject);
        });
    });

    function getAllLists(){
        $.ajax({
            url: "/FoodRun/run/list",
            type: "GET",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function(data){
                mainData = data;
                _renderLists(data);
            }
        });
    }

    function _renderLists(data){
        $('#allLists').html('');
        var html = ""
        $(data).each(function(i, list){
            html += '<div class="panel panel-default singlePanel">' +
                    '<div class="panel-heading">' +
                    '<h3 class="panel-title">'+list.name+'</h3>' +
                    '</div>' +
                    '<div class="panel-body">' +
                    '<ul class="runList" id="runList_'+list.id+'">' +
                    '<span class="text-muted">'+list.items.length+' items</span>';
            $(list.items).each(function(j, item){
                html += '<li id="listItem_'+item.id+'"class="listItem ';
                if(item.checked){
                    html += 'listItemChecked';
                }
                html += '">'+item.name+' <span class="text-muted">(' + item.amount + ')</span>';
                if(item.checked){
                    html += '<input type="checkbox" checked=""></li>';
                }else{
                    html+= '<input type="checkbox"></li>';
                }
            });
            html += '</ul>' +
                    '<div class="btn btn-sm btn-success" style="display:block;">Add Item</div>' +
                    '</div>' +
                    '</div>';
        });

        $('#allLists').append(html);

        $('.runList').each(function(i, run){
            var id = run.id.split('_')[1];
            $('#runList_' + id).data(getRunObject(id));

        });

        $('.listItem').each(function(i, listItem){
            var id = listItem.id.split('_')[1];
            $('#listItem_' + id).data(getListItemObject(id));
        });
    }

    function getRunObject(runId){
        var runObject;
        $(mainData).each(function(i, run){
           if(run.id == runId){
               runObject = run;
           }
        });
        return runObject;
    }

    function getListItemObject(listItemId){
        var listItemObject;
        $(mainData).each(function(i, run){
            $(run.items).each(function(i, listItem){
                if(listItem.id == listItemId){
                    listItemObject = listItem;
                }
            });
        });

        return listItemObject;
    }

    function saveListItem(listItem){
        $.ajax({
            url: "/FoodRun/run/itemSave",
            type: "POST",
            dataType: "json",
            data: JSON.stringify(listItem),
            contentType: "application/json; charset=utf-8",
            success: function(data){
                getAllLists();
            }
        });
    }

</script>
<g:include view="includes/footer.gsp"></g:include>