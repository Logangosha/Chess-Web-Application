// JAVASCRIPT FOR THE SITE MASTER FILE

// Function to convert a hexadecimal color to RGB format

// Function to calculate lightness from an RGB color value
function calculateLightness(color) {
    if (!color) {
        return;
    }

    const rgbComponents = color.match(/\d+/g);
    const red = parseInt(rgbComponents[0], 10);
    const green = parseInt(rgbComponents[1], 10);
    const blue = parseInt(rgbComponents[2], 10);

    const max = Math.max(red, green, blue);
    const min = Math.min(red, green, blue);

    const lightness = (max + min) / 2 / 255;

    return lightness;
}

// CODE FOR THE ACCOUNT PAGE
const root = document.querySelector(":root");

function getColorPickers() {
    if (primaryColorPicker && backgroundColorPicker && statusColorPicker) {
        var colorPickers = [
            primaryColorPicker.value,
            backgroundColorPicker.value,
            statusColorPicker.value,
        ];
        return colorPickers;
    }
}

// Event listeners for color pickers
if (primaryColorPicker) {
    primaryColorPicker.addEventListener("input", () => {
        if (checkContrastRatio(getColorPickers())) {
            root.style.setProperty("--main-color", primaryColorPicker.value);
        } else {
            primaryColorPicker.value = getComputedStyle(root).getPropertyValue(
                "--main-color"
            );
        }
    });
}

if (backgroundColorPicker) {
    backgroundColorPicker.addEventListener("input", () => {
        if (checkContrastRatio(getColorPickers())) {
            root.style.setProperty("--background-color", backgroundColorPicker.value);
        } else {
            backgroundColorPicker.value = getComputedStyle(root).getPropertyValue(
                "--background-color"
            );
        }
    });
}

if (statusColorPicker) {
    statusColorPicker.addEventListener("input", () => {
        if (checkContrastRatio(getColorPickers())) {
            root.style.setProperty("--status-color", statusColorPicker.value);
        } else {
            statusColorPicker.value = getComputedStyle(root).getPropertyValue(
                "--status-color"
            );
        }
    });
}

// Function to check contrast ratio and update style
// only works with three colors in colors array
function checkContrastRatio(colors) {
    const luminanceOffset = 0.05;
    let goodContrast = true;

    // Check contrast ratio conditions
    const relativeLuminance1 = getRelativeLuminance(hexToRgb(colors[0]));
    const relativeLuminance2 = getRelativeLuminance(hexToRgb(colors[1]));
    const relativeLuminance3 = getRelativeLuminance(hexToRgb(colors[2]));

    // Check contrast ratio between colors 1 and 2
    const contrastRatio12 =
        (Math.max(relativeLuminance1, relativeLuminance2) + luminanceOffset) /
        (Math.min(relativeLuminance1, relativeLuminance2) + luminanceOffset);

    if (contrastRatio12 < 4.148) {
        goodContrast = false;
    }

    // Check contrast ratio between colors 1 and 3
    const contrastRatio13 =
        (Math.max(relativeLuminance1, relativeLuminance3) + luminanceOffset) /
        (Math.min(relativeLuminance1, relativeLuminance3) + luminanceOffset);

    if (contrastRatio13 < 1.348) {
        goodContrast = false;
    }

    // Check contrast ratio between colors 2 and 3
    const contrastRatio23 =
        (Math.max(relativeLuminance2, relativeLuminance3) + luminanceOffset) /
        (Math.min(relativeLuminance2, relativeLuminance3) + luminanceOffset);

    if (contrastRatio23 < 1.348) {
        goodContrast = false;
    }

    // Update style if contrast ratio is good
    if (goodContrast) {
        return true;
    } else {
        return false;
    }
}

function hexToRgb(hex) {
    // Ensure hex is a string
    if (typeof hex !== "string") {
        throw new TypeError("hexToRgb expects a string parameter");
    }

    // Remove the '#' symbol from the beginning
    hex = hex.replace("#", "");

    // Extract the red, green, and blue components
    const red = parseInt(hex.substring(0, 2), 16);
    const green = parseInt(hex.substring(2, 4), 16);
    const blue = parseInt(hex.substring(4, 6), 16);

    // Return the RGB color in "rgb(r, g, b)" format
    return `rgb(${red}, ${green}, ${blue})`;
}

// Function to calculate relative luminance from a color
function getRelativeLuminance(color) {
    const red = getComponentValue(color, 0) / 255;
    const green = getComponentValue(color, 1) / 255;
    const blue = getComponentValue(color, 2) / 255;

    const relativeLuminance = 0.2126 * red + 0.7152 * green + 0.0722 * blue;

    return relativeLuminance;
}

// Function to get a component value from a color
function getComponentValue(color, index) {
    if (color.startsWith("rgb")) {
        const rgbValues = color.match(/\d+/g);
        return parseInt(rgbValues[index], 10);
    } else if (color.startsWith("#")) {
        const hexValue = color.substring(index * 2 + 1, index * 2 + 3);
        return parseInt(hexValue, 16);
    }
}

// Function to generate a random color
function generateRandomColor() {
    // Generate a random number between 0 and 16777215 (0xFFFFFF in decimal)
    var randomColor = Math.floor(Math.random() * 16777215).toString(16);

    // Pad the color with zeros if necessary to ensure a 6-digit value
    while (randomColor.length < 6) {
        randomColor = "0" + randomColor;
    }

    // Prepend a '#' to the color code
    randomColor = "#" + randomColor;

    return randomColor;
}

// Function to generate a random color palette theme from three colors
function generateRandomTheme() {
    // Generate 3 random colors and check contrast ratio
    var colors = [];
    let i = 1;
    let goodContrast = false;
    while (!goodContrast) {
        colors.push(generateRandomColor());
        colors.push(generateRandomColor());
        colors.push(generateRandomColor());
        if (checkContrastRatio(colors)) {
            goodContrast = true;
        } else {
            colors = [];
        }
    }
    primaryColorPicker.value = colors[0];
    root.style.setProperty("--main-color", primaryColorPicker.value);
    backgroundColorPicker.value = colors[1];
    root.style.setProperty("--background-color", backgroundColorPicker.value);
    statusColorPicker.value = colors[2];
    root.style.setProperty("--status-color", statusColorPicker.value);
}
