import React, { useState, useEffect, useRef } from 'react';
import './App.css';

const HighlightTextarea: React.FC = () => {
  const [text, setText] = useState<string>(
    "This demo shows how to highlight specific keywords within a textarea. Feel free to edit this text."
  );

  const textareaRef = useRef<HTMLTextAreaElement>(null);
  const highlightsRef = useRef<HTMLDivElement>(null);

  const applyHighlights = (text: string, highlightChars: string[]): string => {
    const regex = new RegExp(`[${highlightChars.join('')}]`, 'gi');
    const words = text.split(/(\s+)/); // Split by spaces while keeping spaces
    return words
      .map((word, index) => {
        if (/\s+/.test(word)) {
          return word; // Keep spaces unchanged
        } else if (regex.test(word)) {
          return `<mark>${word}</mark>`; // Highlight words containing specified chars
        } else {
          return word; // Other words remain unchanged
        }
      })
      .join('');
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