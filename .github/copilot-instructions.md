# GitHub Copilot Instructions for Business Central AL Development

**Summary:**
These instructions define best practices, structure, and code quality standards for Microsoft Dynamics 365 Business Central AL development. They are clear, actionable, and designed for maintainability and collaboration. All contributors should follow these guidelines for consistent, high-quality results.

## Overview
These instructions guide GitHub Copilot to provide optimal assistance for Microsoft Dynamics 365 Business Central AL (Application Language) development.

## 📁 Project structure

Organize the AL project following this hierarchy:

- `app/Codeunits/`
- `app/Pages/`
- `app/PageExtensions/`
- `app/Reports/`
- `app/ReportExtensions/`
- `app/Tables/`
- `app/TableExtensions/`
- `app/Enums/`
- `app/EnumExtensions/`
- `app/Interfaces/`
- `app/Permissions/`
- `app/Queries/`
- `app/dotnet/`
- `test/TestLibraries/`
- `test/TestPages/`
- `test/TestCodeunits/`
- `docs/`
- `scripts/`


## ✍️ Code style and AL Language Specifics

### Code Structure and Conventions
- Follow AL naming conventions: PascalCase for objects and procedures.
- Use `camelCase` for variables.
- Use expressive and descriptive names that clearly indicate the purpose for procedures and variables.
- Prefix custom objects and fields with "APA".
- Add descriptive comments before code blocks and always include proper documentation using XML comments (///).
- Always add a comment to all captions to translate it to Spanish. This comment should start with "ESP=" and add the translation with quotes.
- Keep the code modular and clean.
- Avoid ambiguous abbreviations.
- Use #region to separate initialization logic, validation, and events. Example:
    ```al
    #region Validation
    // ...validation code...
    #endregion
    ```
- Document each object in its corresponding file.
- Use the file naming convention: `<ObjectName>.<ObjectType>.al`.
- Include automated tests in the test/ folder (unit, integration, scenario).
- Also document local procedures and clarify when to use `local` vs. `global`.
- Limit procedures to a maximum of 50 lines.
- Group procedures by purpose within Codeunits.
- Use TODO and FIXME comments for known issues or future improvements.
- Never use text constants, always use labels
- Use UserId() with parentheses at the end
- Use CurrentDateTime() with parentheses at the end
- Choose adequate parameter form .Modify and .Insert
- Add adecuate indirect permissions in lowercase only in Codeunits, Pages and PageExtensions
- Always use returned value from .Get() instructions

## 💬 Example of a useful comment

```al
/// <summary>
/// CalculateDiscountedTotal
/// This procedure calculate the total amount discount applied to a Sales Line and return it as a Decimal amount.
/// </summary>
/// <param name="SalesLine">var Record \"Sales Line\"</param>
/// <param name="SalesHeader">Record \"Sales Header\"</param>
/// <returns name="Output">Decimal</returns>
procedure CalculateDiscountedTotal(var SalesLine: Record \"Sales Line\"; SalesHeader: Record \"Sales Header\") Output: Decimal;
```

### Object Types and Best Practices

#### Tables
- Always define a primary key
- Use appropriate field types (Code, Text, Integer, Decimal, Date, DateTime, Boolean, etc.)
- Implement proper field validation using triggers
- Consider data classification for GDPR compliance
- Use TableRelation property for lookups and validations
- Always implement fieldgroups with DropDown and Brick fieldgroup with primary key

```al
table 50100 "APA Customer Loyalty Points"
{
    Caption = 'Customer Loyalty Points', Comment = 'ESP="Puntos de fidelización del cliente"';
    DataClassification = CustomerContent;
    
    fields
    {
        field(50000; "APA Customer No."; Code[20])
        {
            Caption = 'Customer No.', Comment = 'ESP="Nº cliente"';
            TableRelation = Customer."No.";
        }
        
        field(50001; "APA Loyalty Points"; Integer)
        {
            Caption = 'Loyalty Points', Comment = 'ESP="Puntos de fidelización"';
            MinValue = 0;
        }
    }
    
    keys
    {
        key(PK; "Customer No.")
        {
            Clustered = true;
        }
    }

    fieldgroups
    {
        fieldgroup(DropDown; "Customer No.")
        {
        }
        fieldgroup(Brick; "Customer No.")
        {
        }
    }
}
```

#### Pages
- Use appropriate page types (Card, List, ListPart, Document, etc.)
- Implement proper actions and promote important ones
- Use FieldGroups for DropDown and Brick views
- Consider mobile optimization with appropriate controls

```al
page 50100 "APA Customer Loyalty Points"
{
    Caption = 'Customer Loyalty Points Card', Comment = 'ESP="Ficha de puntos de fidelización del cliente"';
    PageType = Card;
    SourceTable = "APA Customer Loyalty Points";
    
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General', Comment = 'ESP="General"';
                
                field("APA Customer No."; Rec."APA Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the customer number.', Comment = 'ESP="Especifica el número de cliente."';
                }
                
                field("APA Loyalty Points"; Rec."APA Loyalty Points")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the loyalty points for the customer.', Comment = 'ESP="Especifica los puntos de fidelización del cliente."';
                }
            }
        }
    }
    
    actions
    {
        area(Processing)
        {
            action(UpdatePoints)
            {
                Caption = 'Update Points', Comment = 'ESP="Actualizar puntos";
                ApplicationArea = All;
                
                trigger OnAction()
                begin
                    // Implementation here
                end;
            }
        }
    }
}
```

#### Enums
- Never use options, always enum datatype
- Zero (0) enum should be used for empty value

```al
enum 50101 "ABC Loyalties"
{
    Extensible = true;
    Caption = 'Loyalities', Comment = 'ESP="Fidelidades"';

    value(0; "")
    {
        Caption = '', Locked = true;
    }
    value(1; Change)
    {
        Caption = 'Change', Comment ='ESP="Cambiar"';
    }
    value(2; Continue)
    {
        Caption = 'Continue', Comment ='ESP="Continuar"';
    }
}
```

#### Codeunits
- Use single responsibility principle
- Implement proper error handling
- Use events for extensibility
- Consider performance implications
- When use CopyStr alway use MaxStrLen as the last parameter
- Use always a labels intead a text constant

```al
codeunit 50100 "ABC Loyalty Management"
{
    /// <summary>
    /// Calculates loyalty points based on purchase amount
    /// </summary>
    /// <param name="PurchaseAmount">The purchase amount as Decimal</param>
    /// <returns name="">Calculated loyalty points as Integer</returns>
    procedure CalculateLoyaltyPoints(PurchaseAmount: Decimal): Integer
    var
        PointsMultiplier: Decimal;
    begin
        PointsMultiplier := 0.01; // 1 point per 100 currency units
        exit(Round(PurchaseAmount * PointsMultiplier, 1));
    end;
    
    [EventSubscriber(ObjectType::Table, Database::Customer, 'OnAfterInsertEvent', '', false, false)]
    local procedure OnAfterInsertCustomer(var Rec: Record Customer)
    var
        CustomerExtension: Record "ABC Customer Extension";
    begin
        CustomerExtension.Init();
        CustomerExtension."Customer No." := Rec."No.";
        CustomerExtension."Loyalty Points" := 0;
        CustomerExtension.Insert();
    end;
}
```

### AL Development Guidelines

#### Error Handling
- Use Error() for user-facing errors
- Use Assert() for development-time checks
- Implement proper validation in table triggers
- Use FieldError() for field-specific errors

#### Performance Considerations
- Use SetRange() and SetFilter() to optimize database queries
- Always use SetCurrentKey before apply filters to records with the correct key for the filters to apply.
- Implement proper keys for frequently used filters
- Use temporary tables for complex calculations
- Consider using Query objects for complex data retrieval

#### Security and Permissions
- Define appropriate permission sets
- Use SecurityFiltering property when needed
- Implement proper user access controls
- Consider data isolation requirements

#### Modern AL Features
- Use var parameters for large records
- Implement interfaces for better code organization
- Always use enums instead of options
- Neve use options
- Leverage AL language extensions and attributes

### Testing Best Practices
- Write unit tests using AL Test Framework
- Use Test Codeunits and Test Pages
- Implement test data setup and cleanup
- Use Assert procedures for validation

```al
codeunit 50101 "ABC Loyalty Tests"
{
    Subtype = Test;
    
    [Test]
    procedure TestLoyaltyPointsCalculation()
    var
        LoyaltyMgmt: Codeunit "ABC Loyalty Management";
        PurchaseAmount: Decimal;
        ExpectedPoints: Integer;
        ActualPoints: Integer;
    begin
        // [GIVEN] A purchase amount
        PurchaseAmount := 1000;
        ExpectedPoints := 10;
        
        // [WHEN] Calculating loyalty points
        ActualPoints := LoyaltyMgmt.CalculateLoyaltyPoints(PurchaseAmount);
        
        // [THEN] Points should be calculated correctly
        Assert.AreEqual(ExpectedPoints, ActualPoints, 'Loyalty points calculation failed');
    end;
}
```

### Integration and APIs
- Use proper API pages for web service integration
- Implement OData web services when needed
- Use standard AL procedures for external integrations
- Consider using REST client for external API calls

### Localization Considerations
- Use proper caption and label handling
- Implement multi-language support
- Consider regional formatting requirements
- Use appropriate date/time handling

### Version Control and ALOps
- Follow proper branching strategies
- Use semantic versioning for extensions
- Implement proper CI/CD pipelines
- Use AL-Go for GitHub for automated builds

## Code Quality Standards
- Always include ApplicationArea property
- Provide meaningful ToolTip texts
- Use proper indentation (4 spaces)
- Keep procedures focused and small
- Document complex business logic
- Use meaningful variable names

## Common Patterns to Suggest
1. Table extension patterns for extending standard objects
2. Event subscriber patterns for customization
3. Interface implementation for loose coupling
4. Factory patterns for object creation
5. Strategy patterns for business logic variations

## AL-Specific Debugging
- Use debugging tools in AL development environment
- Implement proper logging using telemetry
- Use snapshot debugging for complex scenarios
- Leverage AL profiler for performance analysis

Remember to always consider the Business Central platform constraints and follow Microsoft's AL development guidelines and best practices.

---

## ✅ Quick Checklist

- [ ] Correct file naming convention
- [ ] PascalCase for objects/procedures, camelCase for variables
- [ ] "APA" prefix for custom objects/fields
- [ ] XML documentation and Spanish translation comments
- [ ] #region used for code organization
- [ ] Automated tests included (unit, integration, scenario)
- [ ] TODO/FIXME comments for known issues
- [ ] Troubleshooting steps considered
- [ ] Dependencies and AL version up to date
- [ ] Code reviewed via pull request

## Troubleshooting
- Common issues:
    - Permission errors: Check permission sets and user roles.
    - Deployment issues: Ensure correct app.json and dependencies.
    - Compilation errors: Review AL language version and syntax.
    - Data issues: Validate test data and table relations.

## Code Review Best Practices

- All code changes must be peer reviewed via pull request.
- Use the checklist above before submitting for review.
- Reviewers should check for:
    - Adherence to naming conventions and file structure
    - Proper documentation and translation comments
    - Test coverage and code modularity
    - Use of TODO/FIXME for known issues
    - Compliance with security, performance, and AL best practices

---
