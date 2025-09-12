// APA MADCS ButtonGroup Control Add-in
// This script defines a ButtonGroup class for use in Business Central control add-ins.
// It allows dynamic creation, rendering, and removal of button controls in a group.

// Helper for classical inheritance (TypeScript output)
var __extends = (this && this.__extends) || (function () {
    var extendStatics = function (d, b) {
        extendStatics = Object.setPrototypeOf ||
            ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
            function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
        return extendStatics(d, b);
    };
    return function (d, b) {
        extendStatics(d, b);
        function __() { this.constructor = d; }
        d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
    };
})();

// ButtonGroup class extends BaseControl
var ButtonGroup = (function (_super) {
    __extends(ButtonGroup, _super);

    // Constructor: sets up the button group, exposes AddButton/RemoveButton globally
    function ButtonGroup() {
        var _this = _super.call(this) || this;
        _this.controlClass = 'al-button-group';
        _this.buttons = [];
        // Expose AddButton for AL to call
        window.AddButton = (function (caption, title, id, type) {
            _this.add(caption, title, id, type);
        }).bind(_this);
        window.RemoveButton = (function (id) {
            _this.remove(id);
        }).bind(_this);
        return _this;
    }

    // Adds a new button to the group and renders it if the group container exists
    ButtonGroup.prototype.add = function (caption, title, id, type) {
        var btn = new Button();
        btn.setOption('caption', caption);
        btn.setOption('title', title);
        btn.setOption('type', type);
        btn.setOption('id', id);
        if (this.groupContainer) {
            this.renderButton(btn, this.groupContainer);
        }
        this.buttons.push(btn);
    };

    // Renders a single button in the specified container
    ButtonGroup.prototype.renderButton = function (btn, container) {
        btn.container = container;
        btn.create();
    };

    // Removes a button from the DOM by its ID
    ButtonGroup.prototype.remove = function (id) {
        var btn = document.getElementById(id);
        if (btn !== null) {
            btn.remove();
        }
    };

    // Creates the group container and renders all buttons in the group
    ButtonGroup.prototype.create = function () {
        this.groupContainer = document.createElement('div');
        this.groupContainer.classList.add('al-button-group');
        for (var _i = 0, _a = this.buttons; _i < _a.length; _i++) {
            var btn = _a[_i];
            this.renderButton(btn, this.groupContainer);
        }
        this.container.append(this.groupContainer);
    };

    // Sets up the group after AL signals OnLoad
    ButtonGroup.prototype.setup = function () {
        var _this = this;
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("OnLoad", [], false, (function () {
            _this.create();
        }).bind(this));
    };

    return ButtonGroup;
}(BaseControl));