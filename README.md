# Aito Robot Framework invoice demo

aito-rf-invoice-demo is a simple attended bot, which opens an invoice form in a browser, requests user to input item description, and the fills the remaining fields based on Aito predictions.

The bot uses a public invoice data set from the public 'public-1' Aito instance.


## How to setup?

Run the following commands to install the dependencies.

```
pip3 install aitoai==0.4.0
pip3 install robotframework==3.2.2
pip3 install robotframework-seleniumlibrary
pip3 install webdrivermanager
webdrivermanager firefox chrome --linkpath /usr/local/bin
```

## How to run?

Then start the robot with:

```bash
AITO_INSTANCE_URL=https://public-1.api.aito.ai AITO_API_KEY=bvss2i2dIkaWUfBCdzEO89LpxUkwO3A24hYg8MBq robot aito-invoice-demo.robot
```

The robot will open a browser with an invoice form in it, and open
a dialog with 'OK' button and a message about 'filling the item description'.

Next:

1. Input the item description with e.g. 'Deal estate rent. Deltona Corp'

2. Click the 'OK' button.

3. Robot will fill the invoice form with GL_Code, Product_Category and Vendor_Code predictions. 

