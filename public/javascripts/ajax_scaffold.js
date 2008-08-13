// The following is a cross browser way to move around <tr> elements in a <table> or <tbody>

var Abstract = new Object();
Abstract.Table = function() {};
Abstract.Table.prototype = {
  tagTest: function(element, tagName) {
    return $(element).tagName.toLowerCase() == tagName.toLowerCase();
  }		
};	

Abstract.TableRow = function() {};
Abstract.TableRow.prototype = Object.extend(new Abstract.Table(), {
  initialize: function(targetTableRow, sourceTableRow) {
    try {
      var sourceTableRow = $(sourceTableRow);
      var targetTableRow = $(targetTableRow);
      
      if (targetTableRow == null || !this.tagTest(targetTableRow,'tr') 
      	|| sourceTableRow == null || !this.tagTest(sourceTableRow,'tr')) {
        throw("TableRow: both parameters must be a <tr> tag.");
      }
      
      var tableOrTbody = this.findParentTableOrTbody(targetTableRow);
      
      var newRow = tableOrTbody.insertRow(this.getNewRowIndex(targetTableRow) - this.getRowOffset(tableOrTbody));
      newRow.parentNode.replaceChild(sourceTableRow, newRow);

    } catch (e) {
      alert(e);
    }
  },
  getRowOffset: function(tableOrTbody) {
    //If we are inserting into a tablebody we would need figure out the rowIndex of the first
    // row in that tbody and subtract that offset from the new row index  
    var rowOffset = 0;
    if (this.tagTest(tableOrTbody,'tbody')) {
      rowOffset = tableOrTbody.rows[0].rowIndex;
    }
    return rowOffset;
  },
  findParentTableOrTbody: function(element) {
    var element = $(element);
    // Completely arbitrary value
    var maxSearchDepth = 3;
    var currentSearchDepth = 1;
    var current = element;
    while (currentSearchDepth <= maxSearchDepth) {
      current = current.parentNode;
      if (this.tagTest(current, 'tbody') || this.tagTest(current, 'table')) {
        return current;
      }
      currentSearchDepth++;
    }
  }		
});

var TableRow = new Object();

TableRow.MoveBefore = Class.create();
TableRow.MoveBefore.prototype = Object.extend(new Abstract.TableRow(), {
  getNewRowIndex: function(target) {
    return target.rowIndex;
  }
});

TableRow.MoveAfter = Class.create();
TableRow.MoveAfter.prototype = Object.extend(new Abstract.TableRow(), {
  getNewRowIndex: function(target) {
    return target.rowIndex+1;
  }
});

//Since scriptaculous doesn't support tables and causes and error applying effects to rows in IE 6.0 and Safari we need this wrapper

Abstract.TableEffect = function() {};
Abstract.TableEffect.prototype = Object.extend(new Abstract.Table(), {
  callEffect: function(target, command) {
    var target = $(target);
    if (this.tagTest(target,'tr')) {
      var length = target.cells.length;
      for (var i = 0; i < length; i++) {
        eval("new " + command + "(target.cells[i]);");
      }
    } else {
      eval("new " + command + "(targetElement);");
    }
  }		
});	

var TableEffect = new Object();

TableEffect.Fade = Class.create();
TableEffect.Fade.prototype = Object.extend(new Abstract.TableEffect(), {
  initialize: function(target) {
    this.callEffect(target, 'Effect.Fade');
  }
});

TableEffect.Highlight = Class.create();
TableEffect.Highlight.prototype = Object.extend(new Abstract.TableEffect(), {
  initialize: function(target) {
    this.callEffect(target, 'Effect.Highlight');
  }
});

//The following is a utility to paint beautiful stripes on our table rows, a lot of logic for setting the colors explicitly on each element
// if hightlighting is going to overwrite out CSS styles otherwise.

var TableBodyUtil = {
  enableHighlighting: function(tableBody) {
    this.getColorStore(tableBody).highlighting = true;
  },
  disableHighlighting: function(tableBody) {
    this.getColorStore(tableBody).highlighting = false;
  },
  highlightingEnabled: function(tableBody) {
    var returnValue = true;
    if (this.getColorStore(tableBody).highlighting != null) {
      returnValue = this.getColorStore(tableBody).highlighting;
    }
    return returnValue;
  },
  // We are going to proxy all highlighting through this so that we can uniformly allow/block it (and subsequently paintStripes depending on this)
  highlight: function(target, tableBody) {
    if (this.highlightingEnabled(tableBody)) {
      new TableEffect.Highlight(target); 
    }
  },
  getColorStore: function(tableBody) {
    var uniqueId = tableBody.id;
  
    if (this.tables == null) {
      this.tables = new Object();
    }
    
    if (this.tables[String(uniqueId)] == null) {
      this.tables[String(uniqueId)] = new Object();
    }
    
    return this.tables[String(uniqueId)];
  },
  paintStripes: function(tableBody) {
    var even = false;
    var tableBody = tableBody;
    var tableRows = tableBody.getElementsByTagName("tr");
    var length = tableBody.rows.length;
     
    var colorStore = this.getColorStore(tableBody);  

    for (var i = 0; i < length; i++) {
      var tableRow = tableBody.rows[i];
      //Make sure to skip rows that are create or edit rows or messages
      if (!Element.hasClassName(tableRow, "edit") 
      	&& !Element.hasClassName(tableRow, "create")
      	&& !Element.hasClassName(tableRow, "deleted")
      	&& !Element.hasClassName(tableRow, "message")) {
      	
        if (even) {
          Element.addClassName(tableRow, "even");
          if (this.highlightingEnabled(tableBody)) {
            //If we don't already know what the color is supposed to be we'll poll it from the styles and then save that to apply later
            if (!colorStore.evenColor) {
              colorStore.evenColor = this.getCellBackgroundColor(tableRow);
              // Safari won't pick up the style of the color if the row is not displayed so we are going to hide and then show 
              //  the dummy row if thats what this is.
              if (colorStore.evenColor == null) {
                Element.show(tableRow);
                colorStore.evenColor = this.getCellBackgroundColor(tableRow);
                Element.hide(tableRow);
              }
            }
            this.setCellBackgroundColor(tableRow, colorStore.evenColor);
          }
        } else {
          Element.removeClassName(tableRow, "even");
          
          if (this.highlightingEnabled(tableBody)) {
            if (!colorStore.oddColor) {
              colorStore.oddColor = this.getCellBackgroundColor(tableRow);
            }
            this.setCellBackgroundColor(tableRow, colorStore.oddColor);
          }
        }
        even = !even;
      }
    }
  },
  getCellBackgroundColor: function(tableRow) {
    var tableCell = tableRow.getElementsByTagName("td")[0];
    return Element.getStyle(tableCell, 'background-color');
  },
  setCellBackgroundColor: function(tableRow, color) {
    var length = tableRow.cells.length;
    for (var i = 0; i < length; i++) {
      try {
        tableRow.cells[i].style.backgroundColor = color;
      } catch (e) {
        alert(e);
      }
    }
  },
  countRows: function(tableBody) {
    var tableBody = tableBody;
    var length = tableBody.rows.length;

    var validRows = 0;

    for (var i = 0; i < length; i++) {
      var tableRow = tableBody.rows[i];
      //Make sure to skip rows that are deleted or message
      if (!Element.hasClassName(tableRow, "deleted")
      	&& !Element.hasClassName(tableRow, "message")
      	&& !Element.hasClassName(tableRow, "ignore")) {
        validRows++;
      }
    }
    return validRows;
  }  
}
  
var AjaxScaffold = {  
  newOnLoading: function(request, type) {
    Element.show(this.getNewIndicator(type));
  }, 
  newOnFailure: function(request, type) {
    this.showError(type, request.responseText);
    Element.hide(this.getNewIndicator(type));
  }, 
  newOnSuccess: function(request, type) {
    var createForm = request.responseText;
    
    var id = this.getId(request,type);
    
    new Insertion.Top(this.getTableBodyElement(type), createForm);
    
    Element.hide(this.getEmptyMessageElement(type));
    Element.hide(this.getNewIndicator(type));
    
    var createElement = this.getCreateElement(type, id);
    Element.show(createElement);
    TableBodyUtil.highlight(createElement,this.getTableBodyElement(type));
    Form.focusFirstElement(this.getFormElement('create',type,id));
  }, 


  createOnLoading: function(request,type,id) {
    Element.show(this.getIndicator('create',type,id));
  }, 
  createOnFailure: function(request,type,id) {
    var errorElement = this.getFormErrorElement('create',type,id)
    var errorMessages = request.responseText;
    errorElement.innerHTML = errorMessages;
    Element.show(errorElement);
    Element.hide(this.getIndicator('create',type,id));
  },   
  createOnSuccess: function(request,type,id) {       
    var createElement = this.getCreateElement(type,id);
    
    var view = request.responseText;
    var viewId = this.getId(request,type);
    
    // TODO : Convert this into TableRow.InsertAfter
    new Insertion.Bottom(this.getTableBodyElement(type), view);
    var viewElement = this.getViewElement(type,viewId);
    new TableRow.MoveAfter(createElement, viewElement); 
    
    Element.remove(createElement); 
    Element.show(viewElement);
    
    TableBodyUtil.paintStripes(this.getTableBodyElement(type));  
    TableBodyUtil.highlight(viewElement,this.getTableBodyElement(type));  
  },
  createOnCancel: function(type,id) {
    var createElement = this.getCreateElement(type,id);
    Element.remove(createElement); 
    if (TableBodyUtil.countRows(this.getTableBodyElement(type)) == 0) {
      Element.show(this.getEmptyMessageElement(type));
    }
  }, 


  deleteOnLoading: function(type,id) {

  }, 
  deleteOnFailure: function(type,id) {
    this.showError(type, request.responseText);
  }, 
  deleteOnSuccess: function(type,id) {
    var viewElement = this.getViewElement(type,id);
    
    new TableEffect.Fade(viewElement);
    //We cannot set a timeout to remove this element from the DOM b/c once fade is complete
    // get by ID no longer works on this element. So we'll set a class so that it isn't picked up in a re striping
    Element.addClassName(viewElement, 'deleted');
    
    if (TableBodyUtil.countRows(this.getTableBodyElement(type)) == 0) {
      Element.show(this.getEmptyMessageElement(type));
    } else {
      TableBodyUtil.paintStripes(this.getTableBodyElement(type));
    }
  },
  

  editOnLoading: function(request,type,id) {
    Element.show(this.getIndicator('edit',type,id));
  }, 
  editOnFailure: function(request,type,id) {
    this.showError(type, request.responseText);
    Element.hide(this.getIndicator('edit',type,id));
  },   
  editOnSuccess: function(request,type,id) { 
    var viewElement = this.getViewElement(type,id);

    //Ajax.Update with Insertion.top does not work when being used as a component with other scaffolds on the screen
    // the only safe way it seems it to always insert new elements at the bottom and then move them into the appropriate location
    var editForm = request.responseText;
    
    // TODO : Convert this into TableRow.InsertAfter
    new Insertion.Bottom(this.getTableBodyElement(type), editForm);
    var editElement = this.getEditElement(type,id);
    new TableRow.MoveAfter(viewElement, editElement); 
    
    var formElement = this.getFormElement('edit',type,id);
    
    Element.hide(viewElement); 
    Element.hide(this.getIndicator('edit',type,id));
    Element.show(editElement);
    
    new TableEffect.Highlight(editElement);
    Form.focusFirstElement(formElement);
  },
  
  
  updateOnLoading: function(request,type,id) {
    Element.show(this.getIndicator('update',type,id));
  },
  updateOnFailure: function(request,type,id) {
    var errorElement = this.getFormErrorElement('update',type,id)
    var errorMessages = request.responseText;
    errorElement.innerHTML = errorMessages;
    Element.show(errorElement);
    Element.hide(this.getIndicator('update',type,id));
  }, 
  updateOnSuccess: function(request,type,id) {
    var editElement = this.getEditElement(type,id);
    var formElement = this.getFormElement(type,id);
    var viewElement = this.getViewElement(type,id);
    
    Element.remove(viewElement);
    
    var view = request.responseText;
    
    // TODO : Convert this into a TableRow.InsertBefore
    new Insertion.Bottom(this.getTableBodyElement(type), view);
    var viewElement = this.getViewElement(type,id);
    new TableRow.MoveBefore(editElement, viewElement);
    
    Element.remove(editElement); 
    Element.show(viewElement);
    
    TableBodyUtil.paintStripes(this.getTableBodyElement(type));
    TableBodyUtil.highlight(viewElement,this.getTableBodyElement(type));
  },
  updateOnCancel: function(type,id) {
    var viewElement = this.getViewElement(type,id);
    var editElement = this.getEditElement(type,id);
    
    Element.show(viewElement); 
    Element.remove(editElement);
  },   
  
  
  showError: function(type,html) {
    var errorElement = this.getErrorMessageElement(type);
    var errorMessageElement = errorElement.getElementsByTagName("p")[0];
    errorMessageElement.innerHTML = html;
    Element.show(errorElement);
    TableBodyUtil.highlight(errorElement,this.getTableBodyElement(type));
  },
  hideError: function(type) {
    var errorElement = this.getErrorMessageElement(type);
    Element.hide(errorElement);  
  },
  

  
  getNewIndicator: function(type) {
    return $(type + "-new-loading-indicator");
  },
  getIndicator: function(scope, type,id) {
    return $(type + '-' + scope + '-' + id + "-loading-indicator");
  },
  getFormErrorElement: function(scope,type,id) {
    return $(scope + '-' + type + '-' + id + '-errors')
  },
  getId: function(request, type) {
    return request.getResponseHeader(type + '-id');
  },  
  getCreateElementId: function(type,id) {
    return 'create-' + type + '-' + id;
  },
  getCreateElement: function(type,id) {
    return $('create-' + type + '-' + id);
  },
  getViewElement: function(type,id) {
    return $('view-' + type + '-' + id);
  },
  getEditElement: function(type,id) {
    return $('edit-' + type + '-' + id);
  },
  getFormElement: function(scope,type,id) {
    return $(scope+'-'+type + '-' + id + '-form');
  },
  getEmptyMessageElement: function(type) {
    return $(type + '-empty-message');
  },
  getErrorMessageElement: function(type) {
    return $(type + '-error-message');
  },
  getTableBodyElement: function(type) {
    return $(type + '-list-body');
  }   
}