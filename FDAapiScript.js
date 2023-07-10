
async function getReports() {
    try {
    // Get the zip code from the input field
    let zipCode = document.getElementById("zipCode").value;

    // Define your API endpoint with the zip code as a query parameter
    let url = `https://api.fda.gov/food/enforcement.json?search=postal_code:${zipCode}&limit=5`;

    // Fetch the data from the API
    let response = await fetch(url);

    // If the response status is not ok, throw an error
    if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
}

    // Parse the JSON data
    let data = await response.json();

    // Clear previous results
    document.getElementById("result").innerHTML = "";

    // Display the data in the "result" div
    data.results.forEach((item, i) => {
    document.getElementById("result").innerHTML += `
                <p><strong>Report ${i+1}:</strong></p>
                <p>Product Description: ${item.product_description}</p>
                <p>Reason for Recall: ${item.reason_for_recall}</p>
                <hr>
            `;
        });
    } catch (error) {
        console.error('There has been a problem with your fetch operation:', error);
    }
}

