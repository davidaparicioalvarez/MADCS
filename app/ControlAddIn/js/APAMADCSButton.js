// APA MADCS Button Control Add-in
// This script defines a Button class for use in Business Central control add-ins.

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

// Button class extends BaseControl
var Button = (function (_super) {
    __extends(Button, _super);

    // Constructor: sets up the button's main CSS class
    function Button() {
        var _this = _super.call(this) || this;
        _this.controlClass = 'al-button';
        return _this;
    }

    // Creates and renders the button in the container
    Button.prototype.create = function () {
        var _this = this;
        var button = document.createElement("button");

        // Set button ID if provided
        if (_this.options.id) {
            button.id = _this.options.id;
        }

        // Add main and type-specific CSS classes
        button.classList.add(_this.controlClass);
        if (_this.options.type) {
            button.classList.add("al-button-" + _this.options.type);
        }

        // Set button caption and tooltip
        button.innerHTML = "<span>" + _this.options.caption + "</span>";
        button.title = _this.options.title;

        // Add click event to notify AL via extensibility method
        button.addEventListener("click", (function (e) {
            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("OnClick", [_this.options.id]);
        }).bind(this));

        // Add button to the container
        _this.container.append(button);
    };

    // Sets up the button after AL signals OnLoad
    Button.prototype.setup = function () {
        var _this = this;
        Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("OnLoad", [], false, (function () {
            _this.create();
        }).bind(this));
    };

    return Button;
}(BaseControl));