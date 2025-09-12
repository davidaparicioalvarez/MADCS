// APA MADCS BaseControl for Control Add-ins
// Provides a base class for custom controls in Business Central

var BaseControl = (function () {
    // Constructor: initializes the control's container, class, and options
    function BaseControl() {
        var _this = this;
        // The main HTML element where the control will be rendered.
        this.container = document.getElementById('controlAddIn');
        // CSS class for the control (to be set by child classes).
        this.controlClass = '';
        // Dictionary to store control options (key-value pairs).
        this.options = [];

        // Expose SetOption globally so AL code can call it to update options.
        window.SetOption = (function (key, value) {
            _this.setOption(key, value);
        }).bind(this);
    }

    // Sets an option value by key
    BaseControl.prototype.setOption = function (key, value) {
        this.options[key] = value;
    };

    // Placeholder for setup logic (to be overridden by derived classes)
    BaseControl.prototype.setup = function () { };

    // Renders the control by calling setup, with error handling
    BaseControl.prototype.render = function () {
        try {
            this.setup();
        } catch (err) {
            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod("OnError", [err.message]);
        }
    };

    return BaseControl;
}());