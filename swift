const applyHighlights = (text: string, highlightChars: string[]): string => {
  const regex = new RegExp(`(${highlightChars.join('|')})`, 'gi');
  return text.replace(/\b\w+\b/g, word => {
    if (highlightChars.some(char => word.toLowerCase().includes(char))) {
      return `<mark>${word}</mark>`;
    }
    return word;
  });
};