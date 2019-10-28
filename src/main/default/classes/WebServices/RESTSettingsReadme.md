# Using RESTSettings custom meta data type

## Configuration

### Remote Site Access

To be able to access remote resources first you need to configure a remote site setting. To do so go to Setup -> Security -> Remote site settings, click the 'New Remote Site' button and configure the following settings:

* **Remote Site Name:** Name of the remote site
* **Remote Site URL:** Remote site URL
* **Active:** This checkbox must be selected

### Custom Metadata

1. Navigate to Setup -> Custom Code -> Custom Metadata Types
1. Create new custom metadata type called 'REST Settings' as follows:

* **Singular Label:** Rest Settings
* **Plural Label:** Rest Settings
* **Object name:** Rest_Settings
* **API Name (automatically generated):** REST_Settings\_\_mdt

1. Create custom field for the metadata type with the following settings:

* **Field Label:** value
* **Field Name:** value
* **Data Type:** Text(255)
* **API Name (automatically generated):** value\_\_c

1. Edit the records in the custom metadata type by clicking the **"Manage REST Settings""** button.

1. Create the following records:

* **REST Endpoint**
  * _Label:_ REST_Endpoint
  * _REST Settings Name:_ REST_Endpoint
  * _value:_ The value for the REST endpoint used for the connection
* **REST User**
  * _Label:_ REST_User
  * _REST Settings Name:_ REST_User
  * _value:_ The value for the REST user used for the connection
* **REST Password**
  * _Label:_ REST_Password
  * _REST Settings Name:_ REST_Password
  * _value:_ The value for the REST password used for the connection
