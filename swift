import React, { useState, useEffect, useRef } from 'react';
import './App.css';

const HighlightTextarea: React.FC = () => {
  const [text, setText] = useState<string>(
    "This demo shows how to highlight specific keywords within a textarea. Feel free to edit this text."
  );

  const textareaRef = useRef<HTMLTextAreaElement>(null);
  const highlightsRef = useRef<HTMLDivElement>(null);

  const applyHighlights = (text: string, highlightChars: string[]): string => {
    const words = text.split(/\b/); // Split text into words based on word boundaries
    return words
      .map(word => {
        if (word.match(/^\w+$/i)) {
          const lowerCaseWord = word.toLowerCase();
          if (highlightChars.some(char => lowerCaseWord.includes(char))) {
            return `<mark>${word}</mark>`; // Highlight word if it contains any character in highlightChars
          }
        }
        return word;
      })
      .join(''); // Join words back into a single string
  };

  const handleInput = (event: React.ChangeEvent<HTMLTextAreaElement>) => {
    setText(event.target.value);
  };

  const syncScroll = () => {
    if (textareaRef.current && highlightsRef.current) {
      highlightsRef.current.scrollTop = textareaRef.current.scrollTop;
      highlightsRef.current.scrollLeft = textareaRef.current.scrollLeft;
    }
  };

  useEffect(() => {
    const highlightChars = ['w', 'g']; // Define characters to highlight
    if (highlightsRef.current) {
      highlightsRef.current.innerHTML = applyHighlights(text, highlightChars);
    }
  }, [text]);

  useEffect(() => {
    if (textareaRef.current) {
      textareaRef.current.addEventListener('scroll', syncScroll);
    }
    return () => {
      if (textareaRef.current) {
        textareaRef.current.removeEventListener('scroll', syncScroll);
      }
    };
  }, []);

  return (
    <div className="container">
      <div ref={highlightsRef} className="highlights"></div>
      <textarea
        ref={textareaRef}
        value={text}
        onChange={handleInput}
        className="textarea"
      ></textarea>
    </div>
  );
};

export default HighlightTextarea;