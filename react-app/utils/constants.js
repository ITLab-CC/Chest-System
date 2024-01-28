const apiPrefix = '/api/v2';
// No apiHost => Just apiPrefix
let apiHost = '';
if (process.env.NEXT_PUBLIC_DEV) {
  apiHost = 'http://localhost:8000';
}
export const apiURL = apiHost + apiPrefix;
