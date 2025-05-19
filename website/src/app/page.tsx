import { redirect } from "next/navigation";
import Link from "next/link";

export default async function Home() {
  // Redirect to the video page
  try {
    redirect("/gameplay");
  } catch {
    return (
      <main className="flex min-h-screen flex-col items-center justify-center bg-gradient-to-b from-[#2e026d] to-[#15162c] text-white">
        <div className="container flex flex-col items-center justify-center gap-12 px-4 py-16">
          <h1 className="text-5xl font-extrabold tracking-tight sm:text-[5rem]">
            The Jiaoziria Video
          </h1>
          <p>
            You shouldn&apos;t be here if the redirect worked, please go to{" "}
            <Link href={"/gameplay"}>/gameplay</Link>
          </p>
        </div>
      </main>
    );
  }
}
