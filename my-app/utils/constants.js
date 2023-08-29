const apiPrefix = '/api/v1';
// No apiHost => Just apiPrefix
const apiHost = process.env.NEXT_PUBLIC_API_URL || '';
export const apiURL = apiHost + apiPrefix;
