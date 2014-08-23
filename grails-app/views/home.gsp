<g:include view="includes/header.gsp"></g:include>
<h1 style="margin-left: 10px;">My Grocery Lists</h1>
<a href="#" id="addListButton"class="btn btn-success">Add Run</a>

<div id="allLists" class="panelContainer">

</div>
</div>

<div id="addItemModal" class="modal fade">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
                <h4 class="modal-title">Add Item</h4>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <input class="form-control" id="id" type="hidden" value="" placeholder="ex: Milk">
                </div>
                <div class="form-group">
                    <label class="control-label" for="item">Item Name</label>
                    <input class="form-control" id="item" type="text" value="" placeholder="ex: Milk">
                </div>
                <div class="form-group">
                    <label class="control-label" for="amount">Quantity</label>
                    <input class="form-control" id="amount" type="text" value="">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary" id="saveAddItemButton">Save changes</button>
            </div>
        </div>
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

        $(document).on('click','.addItemButton',function(e){
            var id = e.target.id.split('_')[1];
            $('#addItemModal').find('#id').val(id);
            $('#addItemModal').modal('show');


        });

        $(document).on('click','#saveAddItemButton',function(e){
            var runId = $('#addItemModal').find('#id').val();
            $('#addItemModal').find('#id').val(runId);

            var run = getRunObject(runId);
            var item = {
                name: $('#addItemModal').find('#item').val(),
                amount: $('#addItemModal').find('#amount').val()
            }
            run.items.push(item);

            $.ajax({
                url: "/FoodRun/run/save",
                type: "POST",
                dataType: "json",
                data: JSON.stringify(run),
                contentType: "application/json; charset=utf-8",
                success: function(data){
                    $('#addItemModal').modal('hide');
                    getAllLists();
                }
            });
        });

        $(document).on('mouseover','.listItem',function(e){
            var id = e.target.id.split('_')[1];
            $('#deleteListItem_' + id).show();
        });

        $(document).on('mouseleave','.listItem',function(e){
            var id = e.target.id.split('_')[1];
            $('#deleteListItem_' + id).hide();
        });

        $(document).on('click','.deleteListItem',function(e){
            var id = e.target.id.split('_')[1];
            $('#deleteListItem_' + id).hide();

            deleteListItem(id);
        });


    });

    function getAllLists(){
        $.ajax({
            url: "/FoodRun/run/list",
            type: "GET",
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function(data){
                var sortedData = sortItems(data);
                mainData = sortedData;
                _renderLists(sortedData);
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
                    html += '<input type="checkbox" checked="">';
                }else{
                    html+= '<input type="checkbox">';
                }

                html += '<span id="deleteListItem_'+item.id+'"class="deleteListItem" style="display:none;">x</span></li>';


            });
            html += '</ul>' +
                    '<div id="addItemButton_'+list.id+'"class="btn btn-sm btn-primary addItemButton" style="display:block;">Add Item</div>' +
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

    function sortItems(data){
        $(data).each(function(i, run){
            data[i].items = sortByKey(run.items, 'id');
        });

        return data;
    }

    function sortByKey(array, key) {
        return array.sort(function(a, b) {
            var x = a[key]; var y = b[key];
            return ((x < y) ? -1 : ((x > y) ? 1 : 0));
        });
    }

    function deleteListItem(id){

        var listItem = getListItemObject(id);

        $.ajax({
            url: "/FoodRun/run/itemDelete",
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