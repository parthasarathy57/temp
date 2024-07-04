const applyHighlights = (text: string, highlightChars: string[]): string => {
  const words = text.split(/\b/); // Split text into words based on word boundaries
  return words
    .map(word => {
      if (word.match(/\w+/) && highlightChars.some(char => word.toLowerCase().includes(char))) {
        return `<mark>${word}</mark>`; // Highlight word if it contains any character in highlightChars
      }
      return word;
    })
    .join(''); // Join words back into a single string
};