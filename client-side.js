// For example usage, see README.md
// This script assumes you're running it in a browser environment
// You may need to add the certificate to your system's trust store for this to work without warnings

const url = 'https://folkhostname.local:4273';

fetch(url)
  .then(response => response.text())
  .then(data => {
    console.log('Success:', data);
  })
  .catch((error) => {
    console.error('Error:', error);
  });