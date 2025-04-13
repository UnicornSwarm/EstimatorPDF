Setting this README Up as a set up giude for the UI


1. Trackable Items
This is an EXAMPLE: 
_____________________________________________________________________________________________
let customerLaptop = CustomerItem(
    id: UUID(),
    title: "MacBook Pro",
    description: "Customer's laptop for screen repair",
    notes: "Be careful with fragile screen"
)

let diagnosticsCharge = TrackableItem(from: customerLaptop, unitPrice: 120.00, taxRate: 13.0)
_____________________________________________________________________________________________

::To Access the Customer Object title so object in the care of the business but belonging to lets say a 'Customer' will be taken care of and tracked. 
