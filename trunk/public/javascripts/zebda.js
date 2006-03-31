/*

Zebda javascript library, version 0.2
 http://labs.cavorite.com/zebda
Copyright (C) 2006 Juan Manuel Caicedo

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public
License along with this library; if not, write to the Free Software
Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA


See http://www.gnu.org/copyleft/lesser.html for more information

*/
 
var Zebda = {
  Version: '0.2'
}

if (!JSON || !JSON.parse){
    var JSON = {
      parse: function(str){
         return eval('(' + str + ')')
      }
    }
}

/*

Erik Arvidsson
http://webfx.eae.net/dhtml/sortabletable/api.html
*/
Element.getInnerText = function(element){

  if ((typeof element).search(/string|undefined/) > -1)
      return element

  if (element.innerText)
      return element.innerText;

  var rtn = ''
  var cs = el.childNodes;
  var l = cs.length;
  for (var i = 0; i < l; i++) {
    switch (cs[i].nodeType) {
      case 1: //ELEMENT_NODE
        rtn += Element.getInnerText(cs[i]);
        break;
      case 3: //TEXT_NODE
        rtn += cs[i].nodeValue;
        break;
    }
  }
  return rtn;
}

/*--------------------------------------------------------------------------*/
// Synchronous xml http requests


var SynRequest = {

  json: function(url, options){
    options = options || {}
    options.json = true
    return this.make(url, options)
  },

  make: function (url, options){
    options = options || {}
    options.asynchronous = false
    options.method = 'GET'
    if (options.json){
      options.requestHeaders = ['Accept', 'text/x-json']
      delete options.json
    }

    if (options.args){
      url += '?' + $H(options.args).toQueryString()
      delete options.args
    }

    var r = new Ajax.Request(url, options)

    //Should I try an exception instead?
    if (r.responseIsFailure())
      return new Error(r.transport.status)


    try {
      return JSON.parse(r.transport.responseText)
    }catch(e){}

    if (r.evalJSON()){
      return r.evalJSON()
    }
    return r.transport.responseText
  }
}

 
/*--------------------------------------------------------------------------*/
 

var FormValidator = {
  
  /*
    Namespace prefix
  */
  NSprefix: 'z',

  
  /**
   * Load the defined condition and filters
   * Find all the forms with a validation rule and modify theirs onsubmit function
   */
  init: function(){
    this._definedConditions = new Array()
    for (name in FormValidator.Conditions){
      this._definedConditions.push(name)
    }

    this._definedFilters = new Array()
    for (name in FormValidator.Filters){
      this._definedFilters.push(name)
    }

    var forms =  new Array()

    $A(document.forms).map(function(frm){
      frm._options = eval('(' + frm.getAttribute('z:options') + ')') || {};
      return Form.getElements(frm).map(function(elm){
        FormValidator.Element.init(elm)
        if (FormValidator.Element.hasRules(elm)){
          if (forms.indexOf(frm) == -1)
            forms.push(frm)
        }
      })
    })


    //If exists an onsubmit function, call if the validation went ok
    forms.map(function(f){
      var __submit = (f.onsubmit || function(){return true})
      f.onsubmit = function(){
        return (FormValidator.validate(f) && (__submit.call(f) || false))
      }
      var disp = f.getAttribute('z:display')
      f._displayFunction = (FormValidator.Display[disp] || FormValidator.Display.alert)
    })
  },

  /**
   * Validates a form
   *
   */
  validate: function(form){
    var errs = Form.getElements(form).map(FormValidator.Element.validate).flatten()
    if (errs.length > 0){
      form['_displayFunction'](errs)
      return false
    }
    return true
  },

  /**
   * Functions for display errors
   *
   */
  Display: {


    /*
     * Show inline errors.
     * Based on examples by Cameron Adams:
     * http://www.themaninblue.com/writing/perspective/2005/10/05/
     */
    inline: function(errs){

      $A(document.getElementsByClassName('_zebda_message')).each(function (elm){
        elm.parentNode.removeChild(elm)
      })
      errs.map(function(e){
        var t = document.createElement('span')
        t.className = '_zebda_message correctionText warning'
        t.appendChild(document.createTextNode(e.message))
        e.element.parentNode.insertBefore(t, e.element.nextSibling)

        e.element.focus()
      })
    },

    alert: function(errs){
      alert(errs.pluck('message').join('\n'))
    }
  },

  /**
   * Conditions for the rules
   */
  Conditions: {
    required: function(value){
      return value
    },

    length: function(value){
      var rtn = true
      value = (value || '')
      if (this.options.max)
        rtn = (value.length <= this.options.max)

      if (this.options.min)
        rtn = rtn && (value.length >= this.options.min)

      return rtn
    },

    numeric: function(){
      var rtn, val

      rtn = true;
      val = (this.options.isFloat) ? parseFloat(value) : parseInt(value)

      if (isNaN(val))
        return false

      if (!(this.options.maxValue === undefined))
        rtn = rtn && (this.options.maxValue > val)

      if (!isUndefined(this.args.minValue))
        rtn = rtn && (val > this.options.minValue)

      return rtn
    },

    /**
     *
     */
    regexp: function(value){
      var reg = (this.options.constructor == RegExp) ? this.options : this.options.exp
      return reg.test(value)
    },

    /**
     * Email regular expression
     * bilou mcgyver
     * http://www.regexlib.com/REDetails.aspx?regexp_id=333
     */
    email: function(value){
      var expMail = /^[\w](([_\.\-\+]?[\w]+)*)@([\w]+)(([\.-]?[\w]+)*)\.([A-Za-z]{2,})$/
      return expMail.test(value)
    },

    /**
     * Compare current value with other element
     * TODO
     */
    compare: function(value){
      return false
    },

    /**
     * Apply the rule only when a condition is satisfied
     * TODO
     */
    conditional: function(value){
      return false
    }
  },
  
  /**
   * Filter for text inputs
   *
   */
  Filters: {
    trim: function(value){
      return FormValidator.Filters.trimleft(FormValidator.Filters.trimright(value))
    },
  
    trimleft: function(value){
      return new String(value).replace(/^\s+/, '')
    },
  
    trimright: function(value){
      return new String(value).replace(/\s+$/, '')
    },
  
    /**
     * Replaces the double spaces for single space
     *
     */
    singlespace: function(value){
      return new String(value).replace(/(\s{2,})/g,' ')
    },
  
    lowercase: function(value){
      return new String(value).toLowerCase()
    },

    uppercase: function(value){
      return new String(value).toUpperCase()
    },

    numbers: function(value){
      return new String(value).replace(/([^0-9])/g, '')
    }
  }
 }
 

var Rule = Class.create()
Rule.prototype = {
  initialize: function(element, ruleName, options, message){
    this.condition = Prototype.K
    this.message = (message || '')
    this.options = eval('(' + options + ')');
    this.element = element
    this.condition = FormValidator.Conditions[ruleName] //no bind needed
  },
  evaluate: function(){
    return this['condition'].call(this, Form.Element.getValue(this.element))
  }
}

Rule.Conditions = {

  /**
   * The value is required
   */
  required: function(value){
    return value
  },
  length: function(value){
    var rtn = true
    value = (value || '')
    if (this.options.max)
      rtn = (value.length <= this.options.max)

    if (this.options.min)
      rtn = rtn && (value.length >= this.options.min)

    return rtn
  }
}


var Filter = Class.create()
Filter.prototype = {
  initialize: function(element, filter, options){
    this.element = element
    this.options = eval('(' + options + ')');
    this.evaluate = FormValidator.Filters[filter]
  }
}

FormValidator.Error = Class.create()
FormValidator.Error.prototype = {
  initialize: function(element, message){
    this.element = element
    this.message = message
  },

  inspect: function() {
    return '#<FormValidator.Error:element=' + this.element + ',message=' + this.message + '>'
  }
}

Object.extend(FormValidator,{Element: {
  /**
   *
   */
  init: function(element){

    element._rules = _definedConditions.map(function(cond){
      if (condOptions = element.getAttribute(FormValidator.NSprefix + ':' + cond)){
        var msg = (element.getAttribute(FormValidator.NSprefix + ':' + cond + '_message')
           || element.getAttribute(FormValidator.NSprefix + ':' + 'message'))
        return new Rule(element, cond, condOptions, msg)
      }
    }).compact()

    element._filters = _definedFilters.map(function(filter){
      if (filterValue = element.getAttribute(FormValidator.NSprefix + ':filter_' + filter)){
        return new Filter(element, filter, filterValue)
      }
    }).compact()

    //Inline validation
    if (element.form._options.inline){
      Event.observe(element, 'change', function(){
        element.form['_displayFunction'](FormValidator.Element.validate(this))
        element.focus()
      })
    }
  },

  /**
   * Returns true if the element has any attribute with the namespace
   * prefix
   */
  hasRules: function(element){
    return (element._rules || false)
  },

  /**
   *
   *
   */
  getRules: function(element){
    return (element._rules || [])
  },

  getFilters: function(element){
    return (element._filters || [])
  },

  isText: function(element){
    return ((element.tagName.toLowerCase() == 'input' &&
          (element.type.toLowerCase() == 'text' || element.type.toLowerCase() == 'password')) ||
          (element.tagName.toLowerCase() == 'textarea'))
  },

  /**
   * Filter can only be applied on textboxes, passwords and textarea
   */
  applyFilters: function(element){
    if (FormValidator.Element.isText(element)){
      FormValidator.Element.getFilters(element).each(function(filter){
        element.value = filter.evaluate(element.value)
      })    }
  },

  /**
   * Returns the error objects produced during the validation
   *
   */
  validate: function(element){
    FormValidator.Element.applyFilters(element)
    return FormValidator.Element.getRules(element).map(function(rule){
      if (!rule.evaluate())
        return new FormValidator.Error(element, rule.message)
    }).compact()
  }
}})


/*
Initialize FormValidator after the page has loaded
*/
Event.observe(window,'load',FormValidator.init )
