public class ImageHelpers {

    /* 
     * Method to extract image uploaded as static resource and encode it in base64 format
     * @param resource name of the uploaded static resource
     * @param contentType type of thimage (image/jpeg, image/png, etc)
     * @param characterEncoding encoding of the resulting string 
     * @returns base64 encoded image as string
     */
    public static String extractB64ImageFromStaticResource(String resource, String contentType, String characterEncoding){
		Blob imageBlob = null;

		String resourceUrl = PageReference.forResource(resource).getUrl();
		resourceUrl = resourceUrl.substring(0, resourceUrl.indexOf('?'));

		PageReference page = new PageReference( resourceUrl );
		imageBlob = page.getContent();

		if( imageBlob != null ) {
			return 'data:' + contentType + ';charset=' + characterEncoding + ';base64,' + EncodingUtil.base64Encode(imageBlob);
		} else {
			return null;
		}
	}

    /* 
     * Method to extract image from URL encode it in base64 format
     * @param url url where the image is located
     * @param contentType type of thimage (image/jpeg, image/png, etc)
     * @param characterEncoding encoding of the resulting string 
     * @returns base64 encoded image as string
     */
	public static String extractB64ImageFromUrl(String url, String contantType, string characerEncoding){
		Blob imageBlob = null;

		PageReference page = new PageReference( url );
		imageBlob = page.getContent();

		if( imageBlob != null ) {
			return 'data:' + contentType + ';charset=' + characterEncoding + ';base64,' + EncodingUtil.base64Encode(imageBlob);
		} else {
			return null;
		}
	}

    /* 
     * Method to extract image from SalesForce rich text field and encode it in base64 format
     * @obj SObject containing the rich text field
     * @field API name of the field
     * @param contentType type of thimage (image/jpeg, image/png, etc)
     * @param characterEncoding encoding of the resulting string 
     * @returns base64 encoded image as string
     */
	public static String extractB64ImageFromRichText(SObject obj, SObjectField field, String contentType, String characterEncoding){
		Blob imageBlob = null;

		Matcher imgMatcher = Pattern.compile( '<img(.+?)>' ).matcher( (String) obj.get(field) );
		while ( imgMatcher.find() ) {
			String imageTag = imgMatcher.group();
			String imageURL = imageTag.substringBetween( ' src="', '"' );
			String decodedURL = imageURL.unescapeHtml4();
			PageReference page = new PageReference( decodedURL );
			imageBlob = page.getContent();
		}

		if( imageBlob != null ) {
			return 'data:' + contentType + ';charset=' + characterEncoding + ';base64,' + EncodingUtil.base64Encode(imageBlob);
		} else {
			return null;
		}
	}

    /*
     * Get image encoded as base64 string and convert it to HTML tag 
     * @param content base64 encoded image
     * @returns HTML tag with embeded image
     */
	public static String embedImagesInRichTextContent(String content){
		String returnContent = content;
		Matcher imgMatcher = Pattern.compile( '<img(.+?)></img>' ).matcher( content );
		while ( imgMatcher.find() ) {
			String imageTag = imgMatcher.group();
			String imageURL = imageTag.substringBetween( 'src="', '"' );
			String imageName = imageTag.substringBetween('alt="', '"');

			String contentType = '';
			if ( imageName.substringAfterLast('.') == 'png' ){
				contentType = 'image/png';
			}

			if ( imageName.substringAfterLast('.') == 'jpg' ){
				contentType = 'image/jpg';
			}

			String decodedURL = imageURL.unescapeHtml4();
			PageReference page = new PageReference( decodedURL );
			Blob imageBlob = page.getContent();

			String imageEncoded = '<img src="data:' + contentType + ';charset=utf-8;base64,' + EncodingUtil.base64Encode(imageBlob) + '"></img>';

			returnContent = returnContent.replace(imgMatcher.group(), imageEncoded);
		}

		return returnContent;
	}    
}
