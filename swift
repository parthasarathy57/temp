const applyHighlights = (text: string, highlightChars: string[]): string => {
  const words = text.split(/\s+/); // Split text into words
  return words
    .map(word => {
      if (highlightChars.some(char => word.toLowerCase().includes(char))) {
        return `<mark>${word}</mark>`; // Highlight word if it contains any character in highlightChars
      }
      return word;
    })
    .join(' '); // Join words back into a single string
};