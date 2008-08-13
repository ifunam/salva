/***
 * Excerpted from "Prototype and script.aculo.us",
 * published by The Pragmatic Bookshelf.
 * Copyrights apply to this code. It may not be used to create training material, 
 * courses, books, articles, and the like. Contact us if you are in doubt.
 * We make no guarantees that this code is fit for any purpose. 
 * Visit http://www.pragmaticprogrammer.com/titles/cppsu for more book information.
***/
var Staff = {
  _templates: {
    person: new Template(
      '<span class="leaf">' +
	  '<a href="#" onclick="new Ajax.Updater(\'controller\', \'/addresses/\', {method: \'get\', asynchronous:true, evalScripts:true}); return false;">'+
	  '#{name}</a>' +
      '<input type="checkbox" name="item[]" value="#{id}" /><span>#{name} Aca va el link</span>' +
      '</span>'),
    group: new Template(
      '<span class="group">' +
      '<a href="" title="Click to collapse">' +
      '<img class="toggler" src="group_open.gif" alt="-" /></a>' +
      '<input type="checkbox" name="item[]" value="#{id}" /><span>#{name}</span></span>' +
      '<ul></ul>')
  },

  _currentId: 1000,

  selected: null,

  nodes: [
    { id: 'item1', name: 'ACME',
      children: [
        { id: 'item11', name: 'IT',
          children: [
            { id: 'item111', name: 'Sébastien Gruhier' },
            { id: 'item112', name: 'Alexis Jaubert' },
            { id: 'item113', name: 'Guillaume Réan' }
          ] },
        { id: 'item12', name: 'HR',
          children: [
            { id: 'item121', name: 'Sandrine Daspet' }
          ] },
        { id: 'item13', name: 'Xavier Borderie' }
      ] },
  ],

  create: function(name, isGroup) {
    var container = this.selected ? this.selected.children : this.nodes;
    var node = { id: 'item' + this.genId(), name: name, container: container };
    if (isGroup)
      node.children = [];
    container.push(node);
    return this.createDOMFragment(
      this.selected ? this.selected.id : 'staff', node);
  },

  createDOMFragment: function(parentId, node) {
    var element = new Element('li', { id: node.id });
    var tpl = this._templates[node.children ? 'group' : 'person'];
    var escapedNode = { id: node.id, name: node.name.escapeHTML() };
    element.update(tpl.evaluate(escapedNode));
    $(parentId).down('ul').appendChild(element);
    element.down('input').checked = node.checked;
    this.makeVisible(node.id);
    return node;
  },

  find: function(id, nodes) {
    nodes = nodes || this.nodes;
    var result;
    nodes.each(function(n) {
      result = n.id == id ? n : n.children && this.find(id, n.children);
      if (result)
        throw $break;
    }.bind(this));
    return result;
  },

  genId: function() {
    return ++this._currentId;
  },

  init: function(id, nodes) {
    id = id || 'staff';
    nodes = nodes || this.nodes;
    nodes.each(function(n) {
      n.container = nodes;
      this.createDOMFragment(id, n);
      if (n.children)
        this.init(n.id, n.children);
    }.bind(this));
  },

  makeVisible: function(id) {
    var elt = $(id);
    // Open all containing groups
    while (elt = elt.up('ul'))
      if (!elt.visible())
        this.toggle(elt.up('li').id);
  },

  removeSelected: function() {
    if (!this.selected)
      throw 'No selection to remove';
    var container = this.selected.container;
    container = container.without(this.selected);
    var elt = $(this.selected.id);
    var previous = elt.previous('li');
    if (!previous)
      previous = elt.up('li');
    elt.remove();
    this.selected = null;
    if (previous)
      this.select(previous.id);
    else
      this.updateEditor();
  },

  select: function(id) {
    if (this.selected)
      $(this.selected.id).down('span').removeClassName('selected');
    this.selected = (this.selected && this.selected.id == id
      ? null : this.find(id));
    if (this.selected) {
      var elt = $(id);
      elt.down('span').addClassName('selected');
      this.makeVisible(id);
    }
    this.updateEditor();
    return this.selected;
  },

  toggle: function(id) {
    var elt = $(id);
    var group = elt.down('ul');
    var toggler = elt.down('img');
    var groupIsVisible = group.toggle().visible();
    toggler.src = 'group_' + (groupIsVisible ? 'open' : 'closed') + '.gif';
    toggler.alt = (groupIsVisible ? '-' : '+');
    toggler.up('a').title = 'Click to ' +
      (groupIsVisible ? 'collapse' : 'expand');
  },

  update: function() {
    this.selected.label = $F('edtName');
    $(this.selected.id).down('span', 1).update(
      this.selected.label.escapeHTML());
  },

  updateEditor: function() {
    if (!this.selected) {
      $('edtName').value = '';
      $('chkIsGroup').enable().checked = false;
      $('btnSubmit').value = 'Create';
      $('btnRemove', 'btnAddChild', 'btnSubmit').invoke('disable');
    } else {
      $('edtName').value = this.selected.name;
      var isGroup = this.selected.children;
      $('chkIsGroup').checked = isGroup;
      $('btnSubmit').value = 'Rename';
      $('btnRemove').enable();
      $('btnAddChild', 'chkIsGroup').invoke(isGroup ? 'enable' : 'disable');
    }
    $('edtName').activate();
  }
}; // Staff

function handleTreeClick(e) {
  var elt = e.element();
  if (elt.tagName == 'INPUT')
    return;
  e.stop();
  if (elt.tagName == 'IMG')
    elt = elt.up('a');
  if (elt.tagName == 'A') {
    Staff.toggle(elt.up('li').id);
    return;
  }
  // Other click.  Let's select if we're on a valid item!
  if ('LI' != elt.tagName)
    elt = elt.up('li');
  if (!elt)
    return;
  Staff.select(elt.id);
} // handleTreeClick

function processForm(e, addChild) {
  e.stop();
  if (Staff.selected && !addChild)
    Staff.update($F('edtName'));
  else
    Staff.create($F('edtName'), $('chkIsGroup').checked);
} // processForm

function treeLoader() {
  new Ajax.Request('/trees', {
	  method:'get',
  	  baseParams:{format:'json'},
	  parameters: {id:1},
	  onSuccess: function(transport){
	  nodes = eval(transport.responseText);

	  // document.observe('dom:loaded', function() {
	   Staff.init('staff', nodes);
	   Staff.updateEditor();
	   $('tree').observe('click', handleTreeClick);
	   $('editor').observe('submit', processForm);
	   $('btnRemove').observe('click', Staff.removeSelected.bind(Staff));
	   $('btnAddChild').observe('click',
	    processForm.bindAsEventListener(this, true));

	  new Field.Observer('edtName', 0.3, function() {
	    $('btnSubmit').disabled = $F('edtName').blank();
	  });
	  //});
	 }
	});
 
}
// nodes= [
//    	{ id: 'item1', name: 'ACME',
//      children: [
//        { id: 'item11', name: 'IT' },
//        { id: 'item12', name: 'HR',
//          children: [
//            { id: 'item121', name: 'Sandrine Daspet' }
//          ] },
//      ] },
//  ];
treeLoader();
